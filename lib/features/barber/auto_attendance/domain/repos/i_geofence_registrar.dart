import '../entities/auto_attendance_zone.dart';

abstract class IGeofenceRegistrar {
  Future<bool> register(AutoAttendanceZone zone);

  Future<void> clear();
}
