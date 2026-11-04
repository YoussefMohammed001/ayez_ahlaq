import 'package:equatable/equatable.dart';
import '../../../attendance_feature/domain/entities/attendance_feature_status.dart';
import '../../domain/entities/current_attendance.dart';

enum BarberAttendanceStatus { initial, loading, success, failure }

class BarberAttendanceState extends Equatable {
  final BarberAttendanceStatus status;
  final CurrentAttendance current;
  final AttendanceFeatureStatus feature;
  final DateTime? fetchedAt;
  final String? errorMessage;
  final bool isSubmitting;

  const BarberAttendanceState({
    this.status = BarberAttendanceStatus.initial,
    this.current = const CurrentAttendance.none(),
    this.feature = const AttendanceFeatureStatus.ungated(),
    this.fetchedAt,
    this.errorMessage,
    this.isSubmitting = false,
  });

  bool get hasLoaded => fetchedAt != null;

  bool get isLocked => !feature.enabled;

  BarberAttendanceState copyWith({
    BarberAttendanceStatus? status,
    CurrentAttendance? current,
    AttendanceFeatureStatus? feature,
    DateTime? fetchedAt,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return BarberAttendanceState(
      status: status ?? this.status,
      current: current ?? this.current,
      feature: feature ?? this.feature,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [
    status,
    current,
    feature,
    fetchedAt,
    errorMessage,
    isSubmitting,
  ];
}
