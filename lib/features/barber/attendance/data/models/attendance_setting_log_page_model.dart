import '../../domain/entities/attendance_setting_log_page.dart';
import 'attendance_setting_log_entry_model.dart';

class AttendanceSettingLogPageModel extends AttendanceSettingLogPage {
  const AttendanceSettingLogPageModel({
    required super.entries,
    required super.page,
    required super.totalPages,
  });

  factory AttendanceSettingLogPageModel.fromJson(Map<String, dynamic> json) {
    return AttendanceSettingLogPageModel(
      entries: (json['content'] as List<dynamic>? ?? [])
          .map(
            (e) => AttendanceSettingLogEntryModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }
}
