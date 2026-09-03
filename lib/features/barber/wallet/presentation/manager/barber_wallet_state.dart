import 'package:equatable/equatable.dart';
import '../../domain/entities/barber_wallet.dart';

enum BarberWalletStatus { initial, loading, success, failure }

class BarberWalletState extends Equatable {
  final BarberWalletStatus status;
  final BarberWallet? wallet;
  final String? errorMessage;

  const BarberWalletState({
    this.status = BarberWalletStatus.initial,
    this.wallet,
    this.errorMessage,
  });

  BarberWalletState copyWith({
    BarberWalletStatus? status,
    BarberWallet? wallet,
    String? errorMessage,
  }) {
    return BarberWalletState(
      status: status ?? this.status,
      wallet: wallet ?? this.wallet,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, wallet, errorMessage];
}
