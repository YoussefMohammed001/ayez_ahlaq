import 'package:equatable/equatable.dart';
import '../../domain/entities/current_attendance.dart';

enum BarberAttendanceStatus { initial, loading, success, failure }

class BarberAttendanceState extends Equatable {
  final BarberAttendanceStatus status;
  final CurrentAttendance current;
  final DateTime? fetchedAt;
  final String? errorMessage;
  final bool isSubmitting;

  const BarberAttendanceState({
    this.status = BarberAttendanceStatus.initial,
    this.current = const CurrentAttendance.none(),
    this.fetchedAt,
    this.errorMessage,
    this.isSubmitting = false,
  });

  bool get hasLoaded => fetchedAt != null;

  BarberAttendanceState copyWith({
    BarberAttendanceStatus? status,
    CurrentAttendance? current,
    DateTime? fetchedAt,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return BarberAttendanceState(
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
