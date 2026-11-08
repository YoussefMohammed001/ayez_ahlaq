import '../../../attendance/domain/use_cases/get_current_attendance_use_case.dart';
import '../entities/auto_attendance_eligibility.dart';
import '../entities/auto_attendance_policy.dart';
import '../entities/background_location_status.dart';
import '../entities/enable_auto_attendance_result.dart';
import '../repos/i_auto_attendance_store.dart';
import '../repos/i_background_location_permission.dart';
import '../repos/i_geofence_registrar.dart';

class EnableAutoAttendanceUseCase {
  final GetCurrentAttendanceUseCase _getCurrent;
  final IBackgroundLocationPermission _permission;
  final IGeofenceRegistrar _registrar;
  final IAutoAttendanceStore _store;

  EnableAutoAttendanceUseCase(
    this._getCurrent,
    this._permission,
    this._registrar,
    this._store,
  );

  Future<EnableAutoAttendanceResult> call() async {
    final current = await _getCurrent();
    final config = current.fold((_) => null, (value) => value.config);
    if (config == null) return EnableAutoAttendanceResult.failed;

    final eligibility = AutoAttendancePolicy.eligibilityOf(config);
    if (eligibility == AutoAttendanceEligibility.noShopLocation) {
      return EnableAutoAttendanceResult.noShopLocation;
    }

    final permission = await _permission.request();
    if (permission != BackgroundLocationStatus.granted) {
      return switch (permission) {
        BackgroundLocationStatus.blocked =>
          EnableAutoAttendanceResult.permissionBlocked,
        BackgroundLocationStatus.whileInUseOnly =>
          EnableAutoAttendanceResult.needsAlwaysPermission,
        _ => EnableAutoAttendanceResult.permissionDenied,
      };
    }

    final registered = await _registrar.register(
      AutoAttendancePolicy.zoneOf(config)!,
    );
    if (!registered) return EnableAutoAttendanceResult.failed;

    await _store.setEnabled(true);
    return EnableAutoAttendanceResult.enabled;
  }
}
