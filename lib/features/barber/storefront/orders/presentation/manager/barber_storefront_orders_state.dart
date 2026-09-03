import 'package:equatable/equatable.dart';
import '../../domain/entities/storefront_order.dart';
import '../../domain/entities/storefront_order_status.dart';

enum StorefrontOrdersStatus { initial, loading, success, failure }

class BarberStorefrontOrdersState extends Equatable {
  final StorefrontOrdersStatus status;
  final List<StorefrontOrder> orders;
  final StorefrontOrderStatus? filter;
  final String? errorMessage;
  final int? updatingOrderId;

  const BarberStorefrontOrdersState({
    this.status = StorefrontOrdersStatus.initial,
    this.orders = const [],
    this.filter,
    this.errorMessage,
    this.updatingOrderId,
  });

  List<StorefrontOrder> get visibleOrders => filter == null
      ? orders
      : orders.where((o) => o.status == filter).toList();

  BarberStorefrontOrdersState copyWith({
    StorefrontOrdersStatus? status,
    List<StorefrontOrder>? orders,
    StorefrontOrderStatus? filter,
    bool clearFilter = false,
    String? errorMessage,
    int? updatingOrderId,
  }) {
    return BarberStorefrontOrdersState(
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
