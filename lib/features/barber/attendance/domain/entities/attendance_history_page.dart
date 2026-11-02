import 'package:equatable/equatable.dart';
import 'attendance_shift.dart';

class AttendanceHistoryPage extends Equatable {
  final List<AttendanceShift> shifts;
  final int page;
  final int totalPages;

  const AttendanceHistoryPage({
    required this.shifts,
    required this.page,
    required this.totalPages,
  });

  bool get hasMore => page + 1 < totalPages;

  @override
  List<Object?> get props => [shifts, page, totalPages];
}
