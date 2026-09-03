import '../../domain/entities/barber_wallet.dart';
import 'wallet_transaction_model.dart';

class BarberWalletModel extends BarberWallet {
  const BarberWalletModel({required super.balance, required super.transactions});

  factory BarberWalletModel.fromJson(Map<String, dynamic> json) {
    final transactions = (json['transactions'] as List?) ?? const [];
    return BarberWalletModel(
      balance: (json['balance'] as num?)?.toInt() ?? 0,
      transactions: transactions
          .map((e) => WalletTransactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
