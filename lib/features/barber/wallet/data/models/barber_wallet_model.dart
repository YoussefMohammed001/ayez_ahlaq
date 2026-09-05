import '../../domain/entities/barber_wallet.dart';
import 'wallet_transaction_model.dart';

class BarberWalletModel extends BarberWallet {
  const BarberWalletModel({
    required super.ownerType,
    required super.ownerId,
    required super.ownerName,
    required super.ownerPhone,
    required super.balance,
    required super.held,
    required super.available,
    required super.transactions,
  });

  factory BarberWalletModel.fromJson(Map<String, dynamic> json) {
    final transactions = (json['transactions'] as List?) ?? const [];
    return BarberWalletModel(
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
