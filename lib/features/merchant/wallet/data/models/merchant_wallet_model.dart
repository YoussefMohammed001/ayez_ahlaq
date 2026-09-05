import '../../domain/entities/merchant_wallet.dart';
import 'wallet_transaction_model.dart';

class MerchantWalletModel extends MerchantWallet {
  const MerchantWalletModel({
    required super.ownerType,
    required super.ownerId,
    required super.ownerName,
    required super.ownerPhone,
    required super.balance,
    required super.held,
    required super.available,
    required super.transactions,
  });

  factory MerchantWalletModel.fromJson(Map<String, dynamic> json) {
    final transactions = (json['transactions'] as List?) ?? const [];
    return MerchantWalletModel(
      ownerType: json['ownerType'] as String? ?? '',
      ownerId: (json['ownerId'] as num?)?.toInt() ?? 0,
      ownerName: json['ownerName'] as String? ?? '',
      ownerPhone: json['ownerPhone'] as String? ?? '',
      balance: (json['balance'] as num?)?.toInt() ?? 0,
      held: (json['held'] as num?)?.toInt() ?? 0,
      available: (json['available'] as num?)?.toInt() ?? 0,
      transactions: transactions
          .map((e) => WalletTransactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
