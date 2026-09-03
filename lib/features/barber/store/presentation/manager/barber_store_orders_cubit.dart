import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/store_order_status.dart';
import '../../domain/use_cases/cancel_store_order_use_case.dart';
import '../../domain/use_cases/get_store_orders_use_case.dart';
import 'barber_store_orders_state.dart';

class BarberStoreOrdersCubit extends Cubit<BarberStoreOrdersState> {
  final GetStoreOrdersUseCase _getOrders;
  final CancelStoreOrderUseCase _cancelOrder;

  BarberStoreOrdersCubit(this._getOrders, this._cancelOrder)
      : super(const BarberStoreOrdersState());

  Future<void> loadOrders() async {
    emit(state.copyWith(status: BarberStoreOrdersStatus.loading));

    final result = await _getOrders();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberStoreOrdersStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (orders) => emit(
        state.copyWith(status: BarberStoreOrdersStatus.success, orders: orders),
      ),
    );
  }

  Future<void> cancelOrder(int id) async {
    emit(state.copyWith(cancellingId: id));

    final result = await _cancelOrder(id);

    result.fold(
      (failure) => emit(
        state.copyWith(clearCancellingId: true, errorMessage: failure.message),
      ),
      (_) => emit(
        state.copyWith(
          clearCancellingId: true,
          orders: [
            for (final order in state.orders)
              if (order.id == id)
                order.copyWith(status: StoreOrderStatus.cancelled)
              else
                order,
          ],
        ),
      ),
    );
  }
}
