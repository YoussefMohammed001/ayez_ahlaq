import '../../../../../generated/l10n.dart';

class AttendanceDurationLabel {
  const AttendanceDurationLabel._();

  static String of(int totalMinutes) {
    final hours = totalMinutes ~/ Duration.minutesPerHour;
    final minutes = totalMinutes % Duration.minutesPerHour;

    if (hours == 0) return S().attendanceMinutesOnly(minutes);
    if (minutes == 0) return S().attendanceHoursOnly(hours);
    return S().attendanceHoursAndMinutes(hours, minutes);
  }
}
