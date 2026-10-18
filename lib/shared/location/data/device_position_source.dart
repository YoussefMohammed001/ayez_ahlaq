import 'package:geolocator/geolocator.dart';
import '../../../core/cache/preferences_storage/preferences_storage.dart';
import '../../../core/cache/preferences_storage/preferences_storage_keys.dart';
import '../../../core/helpers/safe_print.dart';
import '../domain/entities/geo_point.dart';

class DevicePositionSource {
  static const _timeout = Duration(seconds: 8);

  final PreferencesStorage _preferences;
  GeoPoint? _lastPoint;

  DevicePositionSource(this._preferences);

  Future<GeoPoint?> resolve() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: _timeout,
        ),
      ).timeout(_timeout);
      return await _remember(GeoPoint(position.latitude, position.longitude));
    } catch (error) {
      safePrint('current position failed: $error');
      return await _lastKnown() ?? _lastPoint ?? _stored();
    }
  }

  Future<GeoPoint?> _lastKnown() async {
    try {
      final position = await Geolocator.getLastKnownPosition();
      if (position == null) return null;
      return await _remember(GeoPoint(position.latitude, position.longitude));
    } catch (_) {
      return null;
    }
  }

  Future<GeoPoint> _remember(GeoPoint point) async {
    _lastPoint = point;
    await _preferences.putString(
      key: PreferencesKeys.lastLatitude,
      value: point.latitude.toString(),
    );
    await _preferences.putString(
      key: PreferencesKeys.lastLongitude,
      value: point.longitude.toString(),
    );
    return point;
  }

  GeoPoint? _stored() {
    final latitude = double.tryParse(
      _preferences.getString(key: PreferencesKeys.lastLatitude),
    );
    final longitude = double.tryParse(
      _preferences.getString(key: PreferencesKeys.lastLongitude),
    );
    if (latitude == null || longitude == null) return null;
    return GeoPoint(latitude, longitude);
  }
}
