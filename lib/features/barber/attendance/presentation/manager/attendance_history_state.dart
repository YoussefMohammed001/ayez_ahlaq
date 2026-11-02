import 'package:equatable/equatable.dart';
import '../../domain/entities/attendance_shift.dart';

enum AttendanceHistoryStatus { initial, loading, success, failure }

class AttendanceHistoryState extends Equatable {
  final AttendanceHistoryStatus status;
  final List<AttendanceShift> shifts;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final String? errorMessage;

  const AttendanceHistoryState({
    this.status = AttendanceHistoryStatus.initial,
    this.shifts = const [],
    this.page = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.errorMessage,
  });

  AttendanceHistoryState copyWith({
    AttendanceHistoryStatus? status,
    List<AttendanceShift>? shifts,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    String? errorMessage,
  }) {
    return AttendanceHistoryState(
      status: status ?? this.status,
      shifts: shifts ?? this.shifts,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    shifts,
    page,
    hasMore,
    isLoadingMore,
    errorMessage,
  ];
}
