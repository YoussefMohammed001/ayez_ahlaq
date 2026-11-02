import '../../domain/entities/attendance_history_page.dart';
import 'attendance_shift_model.dart';

class AttendanceHistoryPageModel extends AttendanceHistoryPage {
  const AttendanceHistoryPageModel({
    required super.shifts,
    required super.page,
    required super.totalPages,
  });

  factory AttendanceHistoryPageModel.fromJson(Map<String, dynamic> json) {
    return AttendanceHistoryPageModel(
      shifts: (json['content'] as List<dynamic>? ?? [])
          .map((e) => AttendanceShiftModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }
}
