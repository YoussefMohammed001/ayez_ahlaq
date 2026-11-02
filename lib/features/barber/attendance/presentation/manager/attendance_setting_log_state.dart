import 'package:equatable/equatable.dart';
import '../../domain/entities/attendance_setting_log_entry.dart';

enum AttendanceSettingLogStatus { initial, loading, success, failure }

class AttendanceSettingLogState extends Equatable {
  final AttendanceSettingLogStatus status;
  final List<AttendanceSettingLogEntry> entries;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final String? errorMessage;

  const AttendanceSettingLogState({
    this.status = AttendanceSettingLogStatus.initial,
    this.entries = const [],
    this.page = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.errorMessage,
  });

  AttendanceSettingLogState copyWith({
    AttendanceSettingLogStatus? status,
    List<AttendanceSettingLogEntry>? entries,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    String? errorMessage,
  }) {
    return AttendanceSettingLogState(
      status: status ?? this.status,
      entries: entries ?? this.entries,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    entries,
    page,
    hasMore,
    isLoadingMore,
    errorMessage,
  ];
}
