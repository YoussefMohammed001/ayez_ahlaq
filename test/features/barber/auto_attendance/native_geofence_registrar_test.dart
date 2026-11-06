import 'package:flutter_test/flutter_test.dart';
import 'package:native_geofence/native_geofence.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/data/services/native_geofence_registrar.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/entities/auto_attendance_policy.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_config.dart';

ActiveGeofence _active({
  String id = NativeGeofenceRegistrar.zoneId,
  double lat = 30.05,
  double lng = 31.23,
  double radius = 120,
}) => ActiveGeofence(
  id: id,
  location: Location(latitude: lat, longitude: lng),
  radiusMeters: radius,
  triggers: {GeofenceEvent.enter, GeofenceEvent.exit},
  androidSettings: null,
);

void main() {
  final zone = AutoAttendancePolicy.zoneOf(
    const AttendanceConfig(
      shopLat: 30.05,
      shopLng: 31.23,
      rangeMeters: 150,
      enforced: true,
    ),
  )!;

  test('the radius the platform hands back is still the same zone', () {
    expect(
      NativeGeofenceRegistrar.isSameZone(_active(radius: 120), zone),
      isTrue,
    );
    expect(
      NativeGeofenceRegistrar.isSameZone(_active(radius: 120.0000001), zone),
      isTrue,
    );
  });

  test('coordinates rounded by the platform still match', () {
    expect(
      NativeGeofenceRegistrar.isSameZone(
        _active(lat: 30.0500001, lng: 31.2299999),
        zone,
      ),
      isTrue,
    );
  });

  test('a moved shop or a changed range is a different zone', () {
    expect(
      NativeGeofenceRegistrar.isSameZone(_active(lat: 30.06), zone),
      isFalse,
    );
    expect(
      NativeGeofenceRegistrar.isSameZone(_active(radius: 160), zone),
      isFalse,
    );
    expect(
      NativeGeofenceRegistrar.isSameZone(_active(id: 'other'), zone),
      isFalse,
    );
  });
}
