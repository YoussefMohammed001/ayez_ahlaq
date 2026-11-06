import '../entities/geofence_transition.dart';

abstract class IAutoAttendanceStore {
  bool get isEnabled;

  Future<void> setEnabled(bool value);

  DateTime? lastEventAt(GeofenceTransition transition);

  Future<void> saveLastEvent(GeofenceTransition transition, DateTime at);
}
