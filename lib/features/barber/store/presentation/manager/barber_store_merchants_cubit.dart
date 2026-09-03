import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_store_merchants_use_case.dart';
import 'barber_store_merchants_state.dart';

class BarberStoreMerchantsCubit extends Cubit<BarberStoreMerchantsState> {
  final GetStoreMerchantsUseCase _getMerchants;

  BarberStoreMerchantsCubit(this._getMerchants)
      : super(const BarberStoreMerchantsState());

  Future<void> loadMerchants() async {
    emit(state.copyWith(status: BarberStoreMerchantsStatus.loading));

    final result = await _getMerchants();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberStoreMerchantsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (merchants) => emit(
        state.copyWith(
          status: BarberStoreMerchantsStatus.success,
          merchants: merchants,
        ),
      ),
    );
  }
}
