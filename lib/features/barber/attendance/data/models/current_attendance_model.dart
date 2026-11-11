import '../../domain/entities/attendance_config.dart';
import '../../domain/entities/current_attendance.dart';
import 'attendance_config_model.dart';
import 'attendance_shift_model.dart';

class CurrentAttendanceModel extends CurrentAttendance {
  const CurrentAttendanceModel({
    required super.shift,
    required super.config,
    super.enabled,
  });

  factory CurrentAttendanceModel.fromJson(Map<String, dynamic> json) {
    final shift = json['shift'];
    final config = json['attendanceConfig'];

    return CurrentAttendanceModel(
      shift: shift is Map<String, dynamic>
          ? AttendanceShiftModel.fromJson(shift)
          : null,
      config: config is Map<String, dynamic>
          ? AttendanceConfigModel.fromJson(config)
          : const AttendanceConfig.none(),
      enabled: json['enabled'] as bool? ?? true,
    );
  }
}
