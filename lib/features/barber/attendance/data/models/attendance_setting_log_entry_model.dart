import '../../domain/entities/attendance_setting_log_entry.dart';

class AttendanceSettingLogEntryModel extends AttendanceSettingLogEntry {
  const AttendanceSettingLogEntryModel({
    required super.id,
    required super.actorName,
    required super.oldRangeMeters,
    required super.newRangeMeters,
    required super.oldEnforced,
    required super.newEnforced,
    required super.createdAt,
  });

  factory AttendanceSettingLogEntryModel.fromJson(Map<String, dynamic> json) {
    return AttendanceSettingLogEntryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      actorName: json['actorName'] as String? ?? '',
      oldRangeMeters: (json['oldRangeMeters'] as num?)?.toInt(),
      newRangeMeters: (json['newRangeMeters'] as num?)?.toInt(),
      oldEnforced: json['oldEnforced'] as bool? ?? false,
      newEnforced: json['newEnforced'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
