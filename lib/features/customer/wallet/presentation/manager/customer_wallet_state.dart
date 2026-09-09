import 'package:equatable/equatable.dart';
import '../../domain/entities/customer_wallet.dart';

enum CustomerWalletStatus { initial, loading, success, failure }

class CustomerWalletState extends Equatable {
  final CustomerWalletStatus status;
  final CustomerWallet? wallet;
  final String? errorMessage;

  const CustomerWalletState({
    this.status = CustomerWalletStatus.initial,
    this.wallet,
    this.errorMessage,
  });

  CustomerWalletState copyWith({
    CustomerWalletStatus? status,
    CustomerWallet? wallet,
    String? errorMessage,
  }) {
    return CustomerWalletState(
      status: status ?? this.status,
      wallet: wallet ?? this.wallet,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, wallet, errorMessage];
}
