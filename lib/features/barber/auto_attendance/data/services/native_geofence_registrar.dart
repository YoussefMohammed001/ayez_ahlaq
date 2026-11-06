import 'package:flutter/foundation.dart';
import 'package:native_geofence/native_geofence.dart';
import '../../../../../core/helpers/safe_print.dart';
import '../../domain/entities/auto_attendance_zone.dart';
import '../../domain/repos/i_geofence_registrar.dart';

class NativeGeofenceRegistrar implements IGeofenceRegistrar {
  static const zoneId = 'shop-attendance';

  final Future<void> Function(GeofenceCallbackParams params) _callback;
  bool _initialized = false;

  NativeGeofenceRegistrar(this._callback);

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await NativeGeofenceManager.instance.initialize();
    _initialized = true;
  }

  static const _radiusToleranceMeters = 1.0;
  static const _coordinateTolerance = 0.00002;

  @visibleForTesting
  static bool isSameZone(ActiveGeofence active, AutoAttendanceZone zone) =>
      active.id == zoneId &&
      (active.radiusMeters - zone.radiusMeters).abs() <=
          _radiusToleranceMeters &&
      (active.location.latitude - zone.latitude).abs() <=
          _coordinateTolerance &&
      (active.location.longitude - zone.longitude).abs() <=
          _coordinateTolerance;

  @override
  Future<bool> register(AutoAttendanceZone zone) async {
    try {
      await _ensureInitialized();
      final manager = NativeGeofenceManager.instance;

      final active = await manager.getRegisteredGeofences();
      if (active.any((g) => isSameZone(g, zone))) return true;

      await manager.removeGeofenceById(zoneId);
      await manager.createGeofence(
        Geofence(
          id: zoneId,
          location: Location(
            latitude: zone.latitude,
            longitude: zone.longitude,
          ),
          radiusMeters: zone.radiusMeters,
          triggers: {GeofenceEvent.enter, GeofenceEvent.exit},
          iosSettings: const IosGeofenceSettings(initialTrigger: false),
          androidSettings: const AndroidGeofenceSettings(initialTriggers: {}),
        ),
        _callback,
      );
      return true;
    } on NativeGeofenceException catch (error) {
      safePrint('Geofence registration failed: ${error.code}');
      return false;
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _ensureInitialized();
      await NativeGeofenceManager.instance.removeAllGeofences();
    } on NativeGeofenceException catch (error) {
      safePrint('Geofence removal failed: ${error.code}');
    }
  }
}
