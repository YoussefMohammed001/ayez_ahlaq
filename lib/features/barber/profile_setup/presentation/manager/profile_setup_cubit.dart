import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/analytics/app_analytics.dart';
import '../../domain/use_cases/get_profile_setup_remote_steps_use_case.dart';
import 'profile_setup_state.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  final GetProfileSetupRemoteStepsUseCase _getRemoteSteps;
  final AppAnalytics _analytics;

  ProfileSetupCubit(this._getRemoteSteps, this._analytics)
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

  Future<void> load() async {
    if (state.status == ProfileSetupStatus.loading) return;

    if (state.status != ProfileSetupStatus.success) {
      emit(state.copyWith(status: ProfileSetupStatus.loading));
    }

    final result = await _getRemoteSteps();

    result.fold(
      (_) => emit(
        state.copyWith(
          status: state.status == ProfileSetupStatus.loading
              ? ProfileSetupStatus.failure
              : state.status,
        ),
      ),
      (done) => emit(
        state.copyWith(status: ProfileSetupStatus.success, remoteDone: done),
      ),
    );
  }

  void syncLocal({required bool hasPhoto, required bool documentsComplete}) {
    if (state.hasPhoto == hasPhoto &&
        state.documentsComplete == documentsComplete) {
      return;
    }
    emit(
      state.copyWith(hasPhoto: hasPhoto, documentsComplete: documentsComplete),
    );
  }
}
