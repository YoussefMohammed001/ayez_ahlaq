import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/location/domain/use_cases/get_current_location_use_case.dart';
import '../../../attendance_feature/domain/entities/attendance_feature_status.dart';
import '../../../attendance_feature/domain/use_cases/get_attendance_feature_status_use_case.dart';
import '../../domain/entities/current_attendance.dart';
import '../../domain/use_cases/check_in_attendance_use_case.dart';
import '../../domain/use_cases/check_out_attendance_use_case.dart';
import '../../domain/use_cases/get_current_attendance_use_case.dart';
import 'attendance_location_message.dart';
import 'barber_attendance_state.dart';

class BarberAttendanceCubit extends Cubit<BarberAttendanceState> {
  static const _featureCodePrefix = 'ATTENDANCE_FEATURE';

  final GetCurrentAttendanceUseCase _getCurrent;
  final CheckInAttendanceUseCase _checkIn;
  final CheckOutAttendanceUseCase _checkOut;
  final GetCurrentLocationUseCase _getLocation;
  final GetAttendanceFeatureStatusUseCase _getFeature;

  BarberAttendanceCubit(
    this._getCurrent,
    this._checkIn,
    this._checkOut,
    this._getLocation,
    this._getFeature,
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

    final featureResult = await _getFeature();

    await featureResult.fold((failure) async => _emitLoadFailure(failure), (
      feature,
    ) async {
      if (!feature.enabled) return _emitLocked(feature);

      final result = await _getCurrent();

      await result.fold(
        (failure) async => _isFeatureRequired(failure)
            ? _emitLocked(await _refreshedFeature(feature))
            : _emitLoadFailure(failure),
        (current) async => _emitCurrent(current, feature),
      );
    });
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

    return result.fold(_emitActionFailure, (current) {
      _emitCurrent(current, state.feature);
      return Future.value(true);
    });
  }

  Future<bool> checkOut() async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _checkOut();

    return result.fold(_emitActionFailure, (_) {
      _emitCurrent(
        CurrentAttendance(shift: null, config: state.current.config),
        state.feature,
      );
      return Future.value(true);
    });
  }

  bool _isFeatureRequired(Failure failure) {
    final code = failure.data['code'];
    return code is String && code.startsWith(_featureCodePrefix);
  }

  Future<AttendanceFeatureStatus> _refreshedFeature(
    AttendanceFeatureStatus fallback,
  ) async {
    final result = await _getFeature();
    return result.getOrElse(() => fallback);
  }

  void _emitCurrent(
    CurrentAttendance current,
    AttendanceFeatureStatus feature,
  ) => emit(
    state.copyWith(
      status: BarberAttendanceStatus.success,
      current: current,
      feature: feature,
      fetchedAt: DateTime.now(),
      isSubmitting: false,
    ),
  );

  void _emitLocked(AttendanceFeatureStatus feature) => emit(
    state.copyWith(
      status: BarberAttendanceStatus.success,
      current: const CurrentAttendance.none(),
      feature: feature,
      fetchedAt: DateTime.now(),
      isSubmitting: false,
    ),
  );

  void _emitLoadFailure(Failure failure) => emit(
    state.copyWith(
      status: BarberAttendanceStatus.failure,
      errorMessage: failure.message,
    ),
  );

  Future<bool> _emitActionFailure(Failure failure) async {
    if (_isFeatureRequired(failure)) {
      await load();
      return false;
    }
    emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
    return false;
  }
}
