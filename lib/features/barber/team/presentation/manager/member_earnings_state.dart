import 'package:equatable/equatable.dart';
import '../../domain/entities/earnings.dart';

enum MemberEarningsStatus { initial, loading, success, failure }

class MemberEarningsState extends Equatable {
  final MemberEarningsStatus status;
  final int? memberId;
  final Earnings earnings;
  final String? errorMessage;

  const MemberEarningsState({
    this.status = MemberEarningsStatus.initial,
    this.memberId,
    this.earnings = const Earnings.empty(),
    this.errorMessage,
  });

  MemberEarningsState copyWith({
    MemberEarningsStatus? status,
    int? memberId,
    Earnings? earnings,
    String? errorMessage,
  }) {
    return MemberEarningsState(
      status: status ?? this.status,
      memberId: memberId ?? this.memberId,
      earnings: earnings ?? this.earnings,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, memberId, earnings, errorMessage];
}
