import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_merchant_wallet_use_case.dart';
import 'merchant_wallet_state.dart';

class MerchantWalletCubit extends Cubit<MerchantWalletState> {
  final GetMerchantWalletUseCase _getWallet;

  MerchantWalletCubit(this._getWallet) : super(const MerchantWalletState());

  Future<void> loadWallet() async {
    emit(state.copyWith(status: MerchantWalletStatus.loading));

    final result = await _getWallet();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: MerchantWalletStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (wallet) => emit(
        state.copyWith(status: MerchantWalletStatus.success, wallet: wallet),
      ),
    );
  }
}
