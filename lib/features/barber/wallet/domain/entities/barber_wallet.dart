import 'package:equatable/equatable.dart';
import 'wallet_transaction.dart';

class BarberWallet extends Equatable {
  final int balance;
  final List<WalletTransaction> transactions;

  const BarberWallet({required this.balance, required this.transactions});

  @override
  List<Object?> get props => [balance, transactions];
}
