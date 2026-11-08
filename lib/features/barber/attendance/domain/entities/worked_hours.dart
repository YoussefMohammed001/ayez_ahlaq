import 'package:equatable/equatable.dart';
import 'attendance_shift.dart';

class WorkedHours extends Equatable {
  final int todayMinutes;
  final int monthMinutes;

  const WorkedHours({required this.todayMinutes, required this.monthMinutes});

  const WorkedHours.none() : todayMinutes = 0, monthMinutes = 0;

  factory WorkedHours.from(List<AttendanceShift> shifts, DateTime now) {
    var today = 0;
    var month = 0;

    for (final shift in shifts) {
      final start = shift.checkInAt;
      if (start.year != now.year || start.month != now.month) continue;

      month += shift.durationMinutes;
      if (start.day == now.day) today += shift.durationMinutes;
    }

    return WorkedHours(todayMinutes: today, monthMinutes: month);
  }

  @override
  List<Object?> get props => [todayMinutes, monthMinutes];
}
