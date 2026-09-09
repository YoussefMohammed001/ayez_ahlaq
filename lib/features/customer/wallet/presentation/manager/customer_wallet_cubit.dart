import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_customer_wallet_use_case.dart';
import 'customer_wallet_state.dart';

class CustomerWalletCubit extends Cubit<CustomerWalletState> {
  final GetCustomerWalletUseCase _getWallet;

  CustomerWalletCubit(this._getWallet) : super(const CustomerWalletState());

  Future<void> loadWallet() async {
    emit(state.copyWith(status: CustomerWalletStatus.loading));

    final result = await _getWallet();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CustomerWalletStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (wallet) => emit(
        state.copyWith(status: CustomerWalletStatus.success, wallet: wallet),
      ),
    );
  }
}
