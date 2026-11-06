import '../entities/auto_attendance_outcome.dart';

abstract class IAutoAttendanceNotifier {
  Future<void> notify(AutoAttendanceOutcome outcome);
}
