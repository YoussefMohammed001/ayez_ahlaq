import 'package:equatable/equatable.dart';
import '../../domain/entities/store_order.dart';
import '../../domain/entities/store_order_status.dart';

enum StoreOrdersStatus { initial, loading, success, failure }

class StoreOrdersState extends Equatable {
  final StoreOrdersStatus status;
  final List<StoreOrder> orders;
  final StoreOrderStatus? filter;
  final String? errorMessage;
  final int? cancellingId;

  const StoreOrdersState({
    this.status = StoreOrdersStatus.initial,
    this.orders = const [],
    this.filter,
    this.errorMessage,
    this.cancellingId,
  });

  List<StoreOrder> get visibleOrders =>
      filter == null ? orders : orders.where((o) => o.status == filter).toList();

  StoreOrdersState copyWith({
    StoreOrdersStatus? status,
    List<StoreOrder>? orders,
    StoreOrderStatus? filter,
    bool clearFilter = false,
    String? errorMessage,
    int? cancellingId,
    bool clearCancellingId = false,
  }) {
    return StoreOrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      filter: clearFilter ? null : (filter ?? this.filter),
      errorMessage: errorMessage,
      cancellingId: clearCancellingId ? null : (cancellingId ?? this.cancellingId),
    );
  }

  @override
  List<Object?> get props => [status, orders, filter, errorMessage, cancellingId];
}
