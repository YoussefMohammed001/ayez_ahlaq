import '../../domain/entities/attendance_config.dart';
import '../../domain/entities/attendance_settings.dart';
import 'attendance_config_model.dart';

class AttendanceSettingsModel extends AttendanceSettings {
  const AttendanceSettingsModel({
    required super.config,
    required super.updatedByName,
    required super.updatedAt,
  });

  factory AttendanceSettingsModel.fromJson(Map<String, dynamic> json) {
    final config = json['attendanceConfig'];
    final updatedAt = json['updatedAt'] as String?;

    return AttendanceSettingsModel(
      config: config is Map<String, dynamic>
          ? AttendanceConfigModel.fromJson(config)
          : const AttendanceConfig.none(),
      updatedByName: json['updatedByName'] as String?,
      updatedAt: updatedAt == null ? null : DateTime.parse(updatedAt),
    );
  }
}
