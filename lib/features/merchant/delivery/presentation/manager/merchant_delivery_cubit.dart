import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/delivery_settings.dart';
import '../../domain/use_cases/get_delivery_use_case.dart';
import '../../domain/use_cases/update_delivery_use_case.dart';
import 'merchant_delivery_state.dart';

class MerchantDeliveryCubit extends Cubit<MerchantDeliveryState> {
  final GetDeliveryUseCase _getDelivery;
  final UpdateDeliveryUseCase _updateDelivery;

  MerchantDeliveryCubit(this._getDelivery, this._updateDelivery)
    : super(const MerchantDeliveryState());

  Future<void> loadDelivery() async {
    emit(state.copyWith(status: DeliveryStatus.loading));

    final result = await _getDelivery();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: DeliveryStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (settings) => emit(
        state.copyWith(status: DeliveryStatus.success, settings: settings),
      ),
    );
  }

  Future<bool> saveDelivery(DeliverySettings settings) async {
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
            status: DeliveryStatus.success,
            settings: saved,
          ),
        );
        return true;
      },
    );
  }
}
