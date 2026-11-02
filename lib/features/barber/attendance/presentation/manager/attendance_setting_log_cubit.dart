import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_attendance_setting_log_use_case.dart';
import 'attendance_setting_log_state.dart';

class AttendanceSettingLogCubit extends Cubit<AttendanceSettingLogState> {
  final GetAttendanceSettingLogUseCase _getLog;

  AttendanceSettingLogCubit(this._getLog)
    : super(const AttendanceSettingLogState());

  Future<void> load() async {
    emit(
      const AttendanceSettingLogState(
        status: AttendanceSettingLogStatus.loading,
      ),
    );

    final result = await _getLog(page: 0);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AttendanceSettingLogStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: AttendanceSettingLogStatus.success,
          entries: page.entries,
          page: page.page,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final result = await _getLog(page: state.page + 1);

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: failure.message),
      ),
      (page) => emit(
        state.copyWith(
          entries: [...state.entries, ...page.entries],
          page: page.page,
          hasMore: page.hasMore,
          isLoadingMore: false,
        ),
      ),
    );
  }
}
