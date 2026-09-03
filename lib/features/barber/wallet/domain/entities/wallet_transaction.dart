import 'package:equatable/equatable.dart';
import 'wallet_transaction_direction.dart';

class WalletTransaction extends Equatable {
  final String code;
  final WalletTransactionDirection direction;
  final int amount;
  final int balanceAfter;
  final String reason;
  final String by;
  final DateTime? at;

  const WalletTransaction({
    required this.code,
    required this.direction,
    required this.amount,
    required this.balanceAfter,
    required this.reason,
    required this.by,
    this.at,
  });

  @override
  List<Object?> get props => [code, direction, amount, balanceAfter, reason, by, at];
}
