import '../../../attendance/domain/entities/attendance_failure_x.dart';
import '../../../attendance/domain/entities/current_attendance.dart';
import '../../../attendance/domain/use_cases/get_current_attendance_use_case.dart';
import '../entities/auto_attendance_policy.dart';
import '../entities/background_location_status.dart';
import '../repos/i_auto_attendance_store.dart';
import '../repos/i_background_location_permission.dart';
import '../repos/i_geofence_registrar.dart';
import 'disable_auto_attendance_use_case.dart';

class SyncAutoAttendanceZoneUseCase {
  final GetCurrentAttendanceUseCase _getCurrent;
  final IBackgroundLocationPermission _permission;
  final IGeofenceRegistrar _registrar;
  final IAutoAttendanceStore _store;
  final DisableAutoAttendanceUseCase _disable;

  SyncAutoAttendanceZoneUseCase(
    this._getCurrent,
    this._permission,
    this._registrar,
    this._store,
    this._disable,
  );

  Future<void> call() async {
    if (!_store.isEnabled) return;

    final current = await _getCurrent();
    final failure = current.fold((value) => value, (_) => null);
    if (failure != null) {
      if (failure.isAttendanceFeatureRequired) await _disable();
      return;
    }
    final config = current
        .getOrElse(() => const CurrentAttendance.none())
        .config;

    final zone = AutoAttendancePolicy.zoneOf(config);
    final permission = await _permission.status();

    if (zone == null || permission != BackgroundLocationStatus.granted) {
      await _disable();
      return;
    }

    await _registrar.register(zone);
  }
}
