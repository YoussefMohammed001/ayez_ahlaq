import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/order_status.dart';
import '../../domain/entities/purchase_order.dart';
import '../../domain/use_cases/accept_order_use_case.dart';
import '../../domain/use_cases/advance_order_status_use_case.dart';
import '../../domain/use_cases/get_orders_use_case.dart';
import '../../domain/use_cases/reject_order_use_case.dart';
import 'merchant_orders_state.dart';

class MerchantOrdersCubit extends Cubit<MerchantOrdersState> {
  final GetOrdersUseCase _getOrders;
  final AcceptOrderUseCase _acceptOrder;
  final RejectOrderUseCase _rejectOrder;
  final AdvanceOrderStatusUseCase _advanceStatus;

  MerchantOrdersCubit(
    this._getOrders,
    this._acceptOrder,
    this._rejectOrder,
    this._advanceStatus,
  ) : super(const MerchantOrdersState());

  Future<void> loadOrders() => _fetch(state.filter);

  Future<void> applyFilter(OrderStatus? status) => _fetch(status);

  Future<void> _fetch(OrderStatus? status) async {
    emit(
      state.copyWith(
        status: OrdersStatus.loading,
        filter: status,
        clearFilter: status == null,
      ),
    );

    final result = await _getOrders(status: status);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OrdersStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (orders) => emit(
        state.copyWith(status: OrdersStatus.success, orders: orders),
      ),
    );
  }

  Future<void> acceptOrder(int id) =>
      _mutate(id, () => _acceptOrder(id));

  Future<void> rejectOrder(int id, String reason) =>
      _mutate(id, () => _rejectOrder(id, reason));

  Future<void> advanceStatus(int id, OrderStatus status) =>
      _mutate(id, () => _advanceStatus(id, status));

  Future<void> _mutate(int id, Future<dynamic> Function() action) async {
    emit(state.copyWith(updatingOrderId: id));

    final result = await action();

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (order) => emit(state.copyWith(orders: _replace(order))),
    );
  }

  List<PurchaseOrder> _replace(PurchaseOrder order) =>
      state.orders.map((o) => o.id == order.id ? order : o).toList();
}
