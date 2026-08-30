import 'package:equatable/equatable.dart';
import '../../domain/entities/order_status.dart';
import '../../domain/entities/purchase_order.dart';

enum OrdersStatus { initial, loading, success, failure }

class MerchantOrdersState extends Equatable {
  final OrdersStatus status;
  final List<PurchaseOrder> orders;
  final OrderStatus? filter;
  final String? errorMessage;
  final int? updatingOrderId;

  const MerchantOrdersState({
    this.status = OrdersStatus.initial,
    this.orders = const [],
    this.filter,
    this.errorMessage,
    this.updatingOrderId,
  });

  List<PurchaseOrder> get pendingOrders =>
      orders.where((o) => o.status.needsDecision).toList();

  MerchantOrdersState copyWith({
    OrdersStatus? status,
    List<PurchaseOrder>? orders,
    OrderStatus? filter,
    bool clearFilter = false,
    String? errorMessage,
    int? updatingOrderId,
  }) {
    return MerchantOrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      filter: clearFilter ? null : (filter ?? this.filter),
      errorMessage: errorMessage,
      updatingOrderId: updatingOrderId,
    );
  }

  @override
  List<Object?> get props => [
    status,
    orders,
    filter,
    errorMessage,
    updatingOrderId,
  ];
}
