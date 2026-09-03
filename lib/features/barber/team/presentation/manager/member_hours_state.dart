import 'package:equatable/equatable.dart';
import '../../../hours/domain/entities/working_day.dart';

enum MemberHoursStatus { initial, loading, success, failure }

class MemberHoursState extends Equatable {
  final MemberHoursStatus status;
  final int? memberId;
  final List<WorkingDay> days;
  final String? errorMessage;
  final bool isSubmitting;

  const MemberHoursState({
    this.status = MemberHoursStatus.initial,
    this.memberId,
    this.days = const [],
    this.errorMessage,
    this.isSubmitting = false,
  });

  MemberHoursState copyWith({
    MemberHoursStatus? status,
    int? memberId,
    List<WorkingDay>? days,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return MemberHoursState(
      status: status ?? this.status,
      memberId: memberId ?? this.memberId,
      days: days ?? this.days,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, memberId, days, errorMessage, isSubmitting];
}
