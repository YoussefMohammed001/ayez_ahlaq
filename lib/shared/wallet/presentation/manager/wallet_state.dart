import 'package:equatable/equatable.dart';
import '../../domain/entities/wallet.dart';

enum WalletStatus { initial, loading, success, failure }

class WalletState extends Equatable {
  final WalletStatus status;
  final Wallet? wallet;
  final String? errorMessage;

  const WalletState({
    this.status = WalletStatus.initial,
    this.wallet,
    this.errorMessage,
  });

  WalletState copyWith({
    WalletStatus? status,
    Wallet? wallet,
    String? errorMessage,
  }) {
    return WalletState(
      status: status ?? this.status,
      wallet: wallet ?? this.wallet,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, wallet, errorMessage];
}
