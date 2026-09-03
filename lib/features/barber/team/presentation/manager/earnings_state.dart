import 'package:equatable/equatable.dart';
import '../../domain/entities/earnings.dart';

enum EarningsStatus { initial, loading, success, failure }

class EarningsState extends Equatable {
  final EarningsStatus status;
  final Earnings earnings;
  final String? errorMessage;

  const EarningsState({
    this.status = EarningsStatus.initial,
    this.earnings = const Earnings.empty(),
    this.errorMessage,
  });

  EarningsState copyWith({
    EarningsStatus? status,
    Earnings? earnings,
    String? errorMessage,
  }) {
    return EarningsState(
      status: status ?? this.status,
      earnings: earnings ?? this.earnings,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, earnings, errorMessage];
}
