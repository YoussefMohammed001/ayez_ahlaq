import '../../domain/entities/wallet_transaction.dart';
import '../../domain/entities/wallet_transaction_direction.dart';

class WalletTransactionModel extends WalletTransaction {
  const WalletTransactionModel({
    required super.code,
    required super.direction,
    required super.amount,
    required super.balanceAfter,
    required super.reason,
    required super.by,
    super.at,
  });

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      code: json['code'] as String? ?? '',
      direction: WalletTransactionDirection.fromApi(json['direction'] as String?),
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      balanceAfter: (json['balanceAfter'] as num?)?.toInt() ?? 0,
      reason: json['reason'] as String? ?? '',
      by: json['by'] as String? ?? '',
      at: DateTime.tryParse(json['at'] as String? ?? ''),
    );
  }
}
