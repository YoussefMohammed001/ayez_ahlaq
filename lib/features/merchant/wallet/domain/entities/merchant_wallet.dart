import 'package:equatable/equatable.dart';
import 'wallet_transaction.dart';

class MerchantWallet extends Equatable {
  final String ownerType;
  final int ownerId;
  final String ownerName;
  final String ownerPhone;
  final int balance;
  final int held;
  final int available;
  final List<WalletTransaction> transactions;

  const MerchantWallet({
    required this.ownerType,
    required this.ownerId,
    required this.ownerName,
    required this.ownerPhone,
    required this.balance,
    required this.held,
    required this.available,
    required this.transactions,
  });

  @override
  List<Object?> get props => [
    ownerType,
    ownerId,
    ownerName,
    ownerPhone,
    balance,
    held,
    available,
    transactions,
  ];
}
