import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/payment_methods/payment_methods_state.dart';
import '../../domain/use_cases/get_barber_payment_methods_use_case.dart';

class BarberPaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  final GetBarberPaymentMethodsUseCase _getEnabledPaymentMethods;

  BarberPaymentMethodsCubit(this._getEnabledPaymentMethods)
    : super(const PaymentMethodsState());

  Future<void> loadMethods() async {
    if (state.methods.isNotEmpty) return;

    emit(state.copyWith(status: PaymentMethodsStatus.loading));

    final result = await _getEnabledPaymentMethods();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PaymentMethodsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (methods) => emit(
        state.copyWith(status: PaymentMethodsStatus.success, methods: methods),
      ),
    );
  }
}
