import 'package:equatable/equatable.dart';
import '../../domain/entities/working_day.dart';

enum BarberHoursStatus { initial, loading, success, failure }

class BarberHoursState extends Equatable {
  final BarberHoursStatus status;
  final List<WorkingDay> days;
  final String? errorMessage;
  final bool isSubmitting;

  const BarberHoursState({
    this.status = BarberHoursStatus.initial,
    this.days = const [],
    this.errorMessage,
    this.isSubmitting = false,
  });

  BarberHoursState copyWith({
    BarberHoursStatus? status,
    List<WorkingDay>? days,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return BarberHoursState(
      status: status ?? this.status,
      days: days ?? this.days,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, days, errorMessage, isSubmitting];
}
