import 'package:equatable/equatable.dart';
import 'attendance_config.dart';
import 'attendance_shift.dart';

class CurrentAttendance extends Equatable {
  final AttendanceShift? shift;
  final AttendanceConfig config;

  const CurrentAttendance({required this.shift, required this.config});

  const CurrentAttendance.none()
    : shift = null,
      config = const AttendanceConfig.none();

  bool get onShift => shift != null;

  @override
  List<Object?> get props => [shift, config];
}
