import '../entities/auto_attendance_outcome.dart';
import '../entities/geofence_transition.dart';

abstract class IAutoAttendanceNotifier {
  Future<void> announceReceived(GeofenceTransition transition);

  Future<void> notify(AutoAttendanceOutcome outcome);
}
