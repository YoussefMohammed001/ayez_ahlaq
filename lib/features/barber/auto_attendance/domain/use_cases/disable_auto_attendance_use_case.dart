import '../repos/i_auto_attendance_store.dart';
import '../repos/i_geofence_registrar.dart';

class DisableAutoAttendanceUseCase {
  final IGeofenceRegistrar _registrar;
  final IAutoAttendanceStore _store;

  DisableAutoAttendanceUseCase(this._registrar, this._store);

  Future<void> call() async {
    await _registrar.clear();
    await _store.setEnabled(false);
  }
}
