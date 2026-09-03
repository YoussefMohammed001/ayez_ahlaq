import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/storefront_order.dart';
import '../../domain/entities/storefront_order_status.dart';
import '../../domain/use_cases/accept_storefront_order_use_case.dart';
import '../../domain/use_cases/advance_storefront_order_status_use_case.dart';
import '../../domain/use_cases/get_storefront_orders_use_case.dart';
import '../../domain/use_cases/reject_storefront_order_use_case.dart';
import 'barber_storefront_orders_state.dart';

class BarberStorefrontOrdersCubit extends Cubit<BarberStorefrontOrdersState> {
  final GetStorefrontOrdersUseCase _getOrders;
  final AcceptStorefrontOrderUseCase _acceptOrder;
  final RejectStorefrontOrderUseCase _rejectOrder;
  final AdvanceStorefrontOrderStatusUseCase _advanceStatus;

  BarberStorefrontOrdersCubit(
    this._getOrders,
    this._acceptOrder,
    this._rejectOrder,
    this._advanceStatus,
  ) : super(const BarberStorefrontOrdersState());

  Future<void> loadOrders() async {
    emit(state.copyWith(status: StorefrontOrdersStatus.loading));

    final result = await _getOrders();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: StorefrontOrdersStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (orders) => emit(
        state.copyWith(status: StorefrontOrdersStatus.success, orders: orders),
      ),
    );
  }

  void applyFilter(StorefrontOrderStatus? status) {
    emit(state.copyWith(filter: status, clearFilter: status == null));
  }

  Future<void> acceptOrder(int id) => _mutate(id, () => _acceptOrder(id));

  Future<void> rejectOrder(int id, String reason) =>
      _mutate(id, () => _rejectOrder(id, reason));

  Future<void> advanceStatus(int id, StorefrontOrderStatus status) =>
      _mutate(id, () => _advanceStatus(id, status));

  Future<void> _mutate(int id, Future<dynamic> Function() action) async {
    emit(state.copyWith(updatingOrderId: id));

    final result = await action();

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (order) => emit(state.copyWith(orders: _replace(order))),
    );
  }

  List<StorefrontOrder> _replace(StorefrontOrder order) =>
      state.orders.map((o) => o.id == order.id ? order : o).toList();
}
