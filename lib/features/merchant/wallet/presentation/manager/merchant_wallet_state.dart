import 'package:equatable/equatable.dart';
import '../../domain/entities/merchant_wallet.dart';

enum MerchantWalletStatus { initial, loading, success, failure }

class MerchantWalletState extends Equatable {
  final MerchantWalletStatus status;
  final MerchantWallet? wallet;
  final String? errorMessage;

  const MerchantWalletState({
    this.status = MerchantWalletStatus.initial,
    this.wallet,
    this.errorMessage,
  });

  MerchantWalletState copyWith({
    MerchantWalletStatus? status,
    MerchantWallet? wallet,
    String? errorMessage,
  }) {
    return MerchantWalletState(
      status: status ?? this.status,
      wallet: wallet ?? this.wallet,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, wallet, errorMessage];
}
