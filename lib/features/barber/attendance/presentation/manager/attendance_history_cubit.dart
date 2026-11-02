import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_attendance_history_use_case.dart';
import 'attendance_history_state.dart';

class AttendanceHistoryCubit extends Cubit<AttendanceHistoryState> {
  final GetAttendanceHistoryUseCase _getHistory;

  AttendanceHistoryCubit(this._getHistory)
    : super(const AttendanceHistoryState());

  Future<void> load() async {
    emit(const AttendanceHistoryState(status: AttendanceHistoryStatus.loading));

    final result = await _getHistory(page: 0);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AttendanceHistoryStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: AttendanceHistoryStatus.success,
          shifts: page.shifts,
          page: page.page,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final result = await _getHistory(page: state.page + 1);

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: failure.message),
      ),
      (page) => emit(
        state.copyWith(
          shifts: [...state.shifts, ...page.shifts],
          page: page.page,
          hasMore: page.hasMore,
          isLoadingMore: false,
        ),
      ),
    );
  }
}
