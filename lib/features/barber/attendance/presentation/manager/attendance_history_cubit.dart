import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/correct_attendance_record_use_case.dart';
import '../../domain/use_cases/get_attendance_history_use_case.dart';
import 'attendance_history_state.dart';

class AttendanceHistoryCubit extends Cubit<AttendanceHistoryState> {
  final GetAttendanceHistoryUseCase _getHistory;
  final CorrectAttendanceRecordUseCase _correct;

  AttendanceHistoryCubit(this._getHistory, this._correct)
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

  Future<bool> correct({
    required int id,
    required DateTime checkInAt,
    required DateTime checkOutAt,
    required String note,
  }) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _correct(
      id: id,
      checkInAt: checkInAt,
      checkOutAt: checkOutAt,
      note: note,
    );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (updated) {
        emit(
          state.copyWith(
            isSubmitting: false,
            shifts: [for (final s in state.shifts) s.id == id ? updated : s],
          ),
        );
        return true;
      },
    );
  }
}
