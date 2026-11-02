import 'package:equatable/equatable.dart';
import '../../domain/entities/attendance_settings.dart';

enum AttendanceSettingsStatus { initial, loading, success, failure }

class AttendanceSettingsState extends Equatable {
  final AttendanceSettingsStatus status;
  final AttendanceSettings? settings;
  final String? errorMessage;
  final bool isSubmitting;

  const AttendanceSettingsState({
    this.status = AttendanceSettingsStatus.initial,
    this.settings,
    this.errorMessage,
    this.isSubmitting = false,
  });

  AttendanceSettingsState copyWith({
    AttendanceSettingsStatus? status,
    AttendanceSettings? settings,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return AttendanceSettingsState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, settings, errorMessage, isSubmitting];
}
