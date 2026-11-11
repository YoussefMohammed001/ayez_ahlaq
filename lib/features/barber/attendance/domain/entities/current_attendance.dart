import 'package:equatable/equatable.dart';
import 'attendance_config.dart';
import 'attendance_shift.dart';

class CurrentAttendance extends Equatable {
  final AttendanceShift? shift;
  final AttendanceConfig config;
  final bool enabled;

  const CurrentAttendance({
    required this.shift,
    required this.config,
    this.enabled = true,
  });

  const CurrentAttendance.none()
    : shift = null,
      config = const AttendanceConfig.none(),
      enabled = true;

  bool get onShift => shift != null;

  @override
  List<Object?> get props => [shift, config, enabled];
}
