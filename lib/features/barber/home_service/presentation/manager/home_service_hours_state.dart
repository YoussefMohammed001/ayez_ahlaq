import 'package:equatable/equatable.dart';
import '../../../hours/domain/entities/working_day.dart';

enum HomeServiceHoursStatus { initial, loading, success, failure }

class HomeServiceHoursState extends Equatable {
  final HomeServiceHoursStatus status;
  final List<WorkingDay> days;
  final String? errorMessage;
  final bool isSubmitting;

  const HomeServiceHoursState({
    this.status = HomeServiceHoursStatus.initial,
    this.days = const [],
    this.errorMessage,
    this.isSubmitting = false,
  });

  HomeServiceHoursState copyWith({
    HomeServiceHoursStatus? status,
    List<WorkingDay>? days,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return HomeServiceHoursState(
      status: status ?? this.status,
      days: days ?? this.days,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, days, errorMessage, isSubmitting];
}
