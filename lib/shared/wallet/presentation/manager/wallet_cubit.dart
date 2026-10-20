import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_wallet_use_case.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final GetWalletUseCase _getWallet;

  WalletCubit(this._getWallet) : super(const WalletState());

  Future<void> loadWallet() async {
    emit(state.copyWith(status: WalletStatus.loading));

    final result = await _getWallet();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: WalletStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (wallet) =>
          emit(state.copyWith(status: WalletStatus.success, wallet: wallet)),
    );
  }
}
