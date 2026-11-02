import 'package:equatable/equatable.dart';
import 'attendance_config.dart';

class AttendanceSettings extends Equatable {
  final AttendanceConfig config;
  final String? updatedByName;
  final DateTime? updatedAt;

  const AttendanceSettings({
    required this.config,
    required this.updatedByName,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [config, updatedByName, updatedAt];
}
