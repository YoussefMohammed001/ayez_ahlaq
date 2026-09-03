import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/storefront_delivery_settings.dart';
import '../../domain/use_cases/get_storefront_delivery_use_case.dart';
import '../../domain/use_cases/update_storefront_delivery_use_case.dart';
import 'barber_storefront_delivery_state.dart';

class BarberStorefrontDeliveryCubit
    extends Cubit<BarberStorefrontDeliveryState> {
  final GetStorefrontDeliveryUseCase _getDelivery;
  final UpdateStorefrontDeliveryUseCase _updateDelivery;

  BarberStorefrontDeliveryCubit(this._getDelivery, this._updateDelivery)
    : super(const BarberStorefrontDeliveryState());

  Future<void> loadDelivery() async {
    emit(state.copyWith(status: StorefrontDeliveryStatus.loading));

    final result = await _getDelivery();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: StorefrontDeliveryStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (settings) => emit(
        state.copyWith(
          status: StorefrontDeliveryStatus.success,
          settings: settings,
        ),
      ),
    );
  }

  Future<bool> saveDelivery(StorefrontDeliverySettings settings) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateDelivery(settings);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (saved) {
        emit(
          state.copyWith(
            isSubmitting: false,
            status: StorefrontDeliveryStatus.success,
            settings: saved,
          ),
        );
        return true;
      },
    );
  }
}
