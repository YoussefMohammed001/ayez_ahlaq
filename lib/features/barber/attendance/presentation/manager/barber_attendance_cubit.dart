import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/location/domain/use_cases/get_current_location_use_case.dart';
import '../../domain/entities/current_attendance.dart';
import '../../domain/use_cases/check_in_attendance_use_case.dart';
import '../../domain/use_cases/check_out_attendance_use_case.dart';
import '../../domain/use_cases/get_current_attendance_use_case.dart';
import 'attendance_location_message.dart';
import 'barber_attendance_state.dart';

class BarberAttendanceCubit extends Cubit<BarberAttendanceState> {
  final GetCurrentAttendanceUseCase _getCurrent;
  final CheckInAttendanceUseCase _checkIn;
  final CheckOutAttendanceUseCase _checkOut;
  final GetCurrentLocationUseCase _getLocation;

  BarberAttendanceCubit(
    this._getCurrent,
    this._checkIn,
    this._checkOut,
    this._getLocation,
  ) : super(const BarberAttendanceState());

  @override
  void emit(BarberAttendanceState state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<void> load() async {
    if (!state.hasLoaded) {
      emit(state.copyWith(status: BarberAttendanceStatus.loading));
    }

    final result = await _getCurrent();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberAttendanceStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      _emitCurrent,
    );
  }

  Future<bool> checkIn() async {
    emit(state.copyWith(isSubmitting: true));

    final location = await _getLocation();
    final point = location.point;

    if (point == null && state.current.config.enforced) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: AttendanceLocationMessage.of(location.availability),
        ),
      );
      return false;
    }

    final result = await _checkIn(lat: point?.latitude, lng: point?.longitude);

    return result.fold(_emitFailure, (current) {
      _emitCurrent(current);
      return true;
    });
  }

  Future<bool> checkOut() async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _checkOut();

    return result.fold(_emitFailure, (_) {
      _emitCurrent(
        CurrentAttendance(shift: null, config: state.current.config),
      );
      return true;
    });
  }

  void _emitCurrent(CurrentAttendance current) => emit(
    state.copyWith(
      status: BarberAttendanceStatus.success,
      current: current,
      fetchedAt: DateTime.now(),
      isSubmitting: false,
    ),
  );

  bool _emitFailure(Failure failure) {
    emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
    return false;
  }
}
