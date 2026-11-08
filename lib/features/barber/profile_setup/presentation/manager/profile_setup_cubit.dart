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
    : super(
        ProfileSetupState(started: _store.started, dismissed: _store.dismissed),
      );

  @override
  void emit(ProfileSetupState state) {
    if (isClosed) return;
    final wasShowingChecklist = this.state.shouldShowChecklist;
    super.emit(state);
    if (wasShowingChecklist && state.isReady && state.progress.isComplete) {
      _analytics.setupCompleted();
    }
  }

  Future<void> load() async {
    if (state.status == ProfileSetupStatus.loading) return;

    if (state.status != ProfileSetupStatus.success) {
      emit(state.copyWith(status: ProfileSetupStatus.loading));
    }

    final result = await _getSnapshot();

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
        await _rememberIfNewShop();
      },
    );
  }

  void syncLocal({required bool hasPhoto}) {
    if (state.hasPhoto == hasPhoto) return;
    emit(state.copyWith(hasPhoto: hasPhoto));
  }

  Future<void> dismiss() async {
    await _store.dismiss();
    emit(state.copyWith(dismissed: true));
  }

  Future<void> _rememberIfNewShop() async {
    if (state.started || !state.requiredIncomplete) return;

    await _store.markStarted();
    emit(state.copyWith(started: true));
  }
}
