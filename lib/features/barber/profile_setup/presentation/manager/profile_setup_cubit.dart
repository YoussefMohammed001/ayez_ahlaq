import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/analytics/app_analytics.dart';
import '../../domain/repos/i_profile_setup_store.dart';
import '../../domain/use_cases/get_profile_setup_snapshot_use_case.dart';
import 'profile_setup_state.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  final GetProfileSetupSnapshotUseCase _getSnapshot;
  final IProfileSetupStore _store;
  final AppAnalytics _analytics;

  ProfileSetupCubit(this._getSnapshot, this._store, this._analytics)
    : super(const ProfileSetupState());

  @override
  void emit(ProfileSetupState state) {
    if (isClosed) return;
    final wasShowingChecklist = this.state.shouldShowChecklist;
    super.emit(state);
    if (wasShowingChecklist && state.isReady && state.progress.isComplete) {
      _analytics.setupCompleted();
    }
  }

  Future<void> start(int ownerId) async {
    if (state.ownerId == ownerId &&
        state.status != ProfileSetupStatus.initial) {
      return;
    }

    emit(
      ProfileSetupState(
        ownerId: ownerId,
        hasPhoto: state.hasPhoto,
        dismissed: _store.isDismissed(ownerId),
      ),
    );
    await load();
  }

  Future<void> load() async {
    final ownerId = state.ownerId;
    if (ownerId == null || state.status == ProfileSetupStatus.loading) return;

    if (state.status != ProfileSetupStatus.success) {
      emit(state.copyWith(status: ProfileSetupStatus.loading));
    }

    final result = await _getSnapshot(alreadyDone: _store.doneSteps(ownerId));

    await result.fold(
      (_) async => emit(
        state.copyWith(
          status: state.status == ProfileSetupStatus.loading
              ? ProfileSetupStatus.failure
              : state.status,
        ),
      ),
      (snapshot) async {
        emit(
          state.copyWith(
            status: ProfileSetupStatus.success,
            snapshot: snapshot,
          ),
        );
        await _remember();
      },
    );
  }

  Future<void> syncLocal({required bool hasPhoto}) async {
    if (state.hasPhoto == hasPhoto) return;

    emit(state.copyWith(hasPhoto: hasPhoto));
    await _remember();
  }

  Future<void> dismiss() async {
    final ownerId = state.ownerId;
    if (ownerId == null) return;

    await _store.dismiss(ownerId);
    emit(state.copyWith(dismissed: true));
  }

  Future<void> _remember() async {
    final ownerId = state.ownerId;
    if (ownerId == null || state.status != ProfileSetupStatus.success) return;

    await _store.saveDoneSteps(ownerId, state.doneSteps);
  }
}
