import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_attendance_feature_requests_use_case.dart';
import 'attendance_feature_requests_state.dart';

class AttendanceFeatureRequestsCubit
    extends Cubit<AttendanceFeatureRequestsState> {
  final GetAttendanceFeatureRequestsUseCase _getRequests;

  AttendanceFeatureRequestsCubit(this._getRequests)
    : super(const AttendanceFeatureRequestsState());

  Future<void> load() async {
    emit(
      const AttendanceFeatureRequestsState(
        status: AttendanceFeatureRequestsStatus.loading,
      ),
    );

    final result = await _getRequests(page: 0);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AttendanceFeatureRequestsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: AttendanceFeatureRequestsStatus.success,
          requests: page.requests,
          page: page.page,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final result = await _getRequests(page: state.page + 1);

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: failure.message),
      ),
      (page) => emit(
        state.copyWith(
          requests: [...state.requests, ...page.requests],
          page: page.page,
          hasMore: page.hasMore,
          isLoadingMore: false,
        ),
      ),
    );
  }
}
