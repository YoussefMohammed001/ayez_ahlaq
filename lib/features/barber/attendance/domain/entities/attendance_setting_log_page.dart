import 'package:equatable/equatable.dart';
import 'attendance_setting_log_entry.dart';

class AttendanceSettingLogPage extends Equatable {
  final List<AttendanceSettingLogEntry> entries;
  final int page;
  final int totalPages;

  const AttendanceSettingLogPage({
    required this.entries,
    required this.page,
    required this.totalPages,
  });

  bool get hasMore => page + 1 < totalPages;

  @override
  List<Object?> get props => [entries, page, totalPages];
}
