import 'package:equatable/equatable.dart';
import '../../../../barber/attendance/domain/entities/current_attendance.dart';

enum MemberAttendanceStatus { initial, loading, success, failure }

class MemberAttendanceState extends Equatable {
  final MemberAttendanceStatus status;
  final CurrentAttendance current;
  final DateTime? fetchedAt;
  final String? errorMessage;
  final bool isSubmitting;

  const MemberAttendanceState({
    this.status = MemberAttendanceStatus.initial,
    this.current = const CurrentAttendance.none(),
    this.fetchedAt,
    this.errorMessage,
    this.isSubmitting = false,
  });

  bool get hasLoaded => fetchedAt != null;

  bool get isDisabled => hasLoaded && !current.enabled;

  MemberAttendanceState copyWith({
    MemberAttendanceStatus? status,
    CurrentAttendance? current,
    DateTime? fetchedAt,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return MemberAttendanceState(
      status: status ?? this.status,
      current: current ?? this.current,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [
    status,
    current,
    fetchedAt,
    errorMessage,
    isSubmitting,
  ];
}
