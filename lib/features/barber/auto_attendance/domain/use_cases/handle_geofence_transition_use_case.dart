import '../../../attendance/domain/entities/attendance_failure_x.dart';
import '../../../attendance/domain/entities/attendance_method.dart';
import '../../../attendance/domain/entities/current_attendance.dart';
import '../../../attendance/domain/use_cases/check_in_attendance_use_case.dart';
import '../../../attendance/domain/use_cases/check_out_attendance_use_case.dart';
import '../../../attendance/domain/use_cases/get_current_attendance_use_case.dart';
import '../entities/auto_attendance_outcome.dart';
import '../entities/auto_attendance_policy.dart';
import '../entities/geofence_transition.dart';
import '../repos/i_auto_attendance_store.dart';
import '../repos/i_geofence_registrar.dart';

class HandleGeofenceTransitionUseCase {
  final GetCurrentAttendanceUseCase _getCurrent;
  final CheckInAttendanceUseCase _checkIn;
  final CheckOutAttendanceUseCase _checkOut;
  final IAutoAttendanceStore _store;
  final IGeofenceRegistrar _registrar;

  HandleGeofenceTransitionUseCase(
    this._getCurrent,
    this._checkIn,
    this._checkOut,
    this._store,
    this._registrar,
  );

  Future<AutoAttendanceOutcome> call(
    GeofenceTransition transition, {
    double? lat,
    double? lng,
  }) async {
    if (!_store.isEnabled) {
      await _registrar.clear();
      return AutoAttendanceOutcome.disabled;
    }

    final current = await _getCurrent();
    final failure = current.fold((value) => value, (_) => null);
    if (failure != null) {
      return failure.isAttendanceFeatureRequired
          ? AutoAttendanceOutcome.featureInactive
          : AutoAttendanceOutcome.failed;
    }
    final attendance = current.getOrElse(() => const CurrentAttendance.none());
    final zone = AutoAttendancePolicy.zoneOf(attendance.config);

    if (transition == GeofenceTransition.entered &&
        zone?.needsTracking == true) {
      return AutoAttendanceOutcome.needsTracking;
    }

    return _apply(transition, attendance.onShift, lat, lng);
  }

  Future<AutoAttendanceOutcome> _apply(
    GeofenceTransition transition,
    bool onShift,
    double? lat,
    double? lng,
  ) async {
    switch (transition) {
      case GeofenceTransition.entered:
        if (onShift) return AutoAttendanceOutcome.alreadyOnShift;
        final result = await _checkIn(
          lat: lat,
          lng: lng,
          method: AttendanceMethod.auto,
        );
        return result.fold(
          (_) => AutoAttendanceOutcome.failed,
          (_) => AutoAttendanceOutcome.checkedIn,
        );
      case GeofenceTransition.exited:
        if (!onShift) return AutoAttendanceOutcome.noOpenShift;
        final result = await _checkOut(
          lat: lat,
          lng: lng,
          method: AttendanceMethod.auto,
        );
        return result.fold(
          (_) => AutoAttendanceOutcome.failed,
          (_) => AutoAttendanceOutcome.checkedOut,
        );
    }
  }
}
