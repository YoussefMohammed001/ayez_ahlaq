import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_barber_wallet_use_case.dart';
import 'barber_wallet_state.dart';

class BarberWalletCubit extends Cubit<BarberWalletState> {
  final GetBarberWalletUseCase _getWallet;

  BarberWalletCubit(this._getWallet) : super(const BarberWalletState());

  Future<void> loadWallet() async {
    emit(state.copyWith(status: BarberWalletStatus.loading));

    final result = await _getWallet();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberWalletStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (wallet) =>
          emit(state.copyWith(status: BarberWalletStatus.success, wallet: wallet)),
    );
  }
}
