import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/use_cases/cancel_attendance_feature_request_use_case.dart';
import '../../domain/use_cases/request_attendance_feature_use_case.dart';
import 'attendance_feature_request_state.dart';

class AttendanceFeatureRequestCubit
    extends Cubit<AttendanceFeatureRequestState> {
  final RequestAttendanceFeatureUseCase _request;
  final CancelAttendanceFeatureRequestUseCase _cancel;

  AttendanceFeatureRequestCubit(this._request, this._cancel)
    : super(const AttendanceFeatureRequestState());

  @override
  void emit(AttendanceFeatureRequestState state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<bool> requestFeature() async {
    emit(state.copyWith(isSubmitting: true));
    return _finish(await _request());
  }

  Future<bool> cancelRequest(int? id) async {
    if (id == null) return false;

    emit(state.copyWith(isSubmitting: true));
    return _finish(await _cancel(id));
  }

  bool _finish(Either<Failure, Unit> result) => result.fold(
    (failure) {
      emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
      return false;
    },
    (_) {
      emit(state.copyWith(isSubmitting: false));
      return true;
    },
  );
}
