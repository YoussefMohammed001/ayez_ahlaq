import 'package:equatable/equatable.dart';
import 'fulfilment_type.dart';
import 'order_item.dart';
import 'order_status.dart';

class PurchaseOrder extends Equatable {
  final int id;
  final String code;
  final String shopName;
  final String barberName;
  final List<OrderItem> items;
  final int subtotal;
  final int orderDiscount;
  final int total;
  final OrderStatus status;
  final FulfilmentType fulfilmentType;
  final List<OrderStatus> nextStatuses;
  final DateTime? createdAt;
  final String? rejectionReason;

  const PurchaseOrder({
    required this.id,
    required this.code,
    required this.shopName,
    required this.barberName,
    required this.items,
    required this.subtotal,
    required this.orderDiscount,
    required this.total,
    required this.status,
    required this.fulfilmentType,
    required this.nextStatuses,
    this.createdAt,
    this.rejectionReason,
  });

  bool get canAdvance => nextStatuses.isNotEmpty;

  PurchaseOrder copyWith({
    OrderStatus? status,
    List<OrderStatus>? nextStatuses,
  }) {
    return PurchaseOrder(
      id: id,
      code: code,
      shopName: shopName,
      barberName: barberName,
      items: items,
      subtotal: subtotal,
      orderDiscount: orderDiscount,
      total: total,
      status: status ?? this.status,
      fulfilmentType: fulfilmentType,
      nextStatuses: nextStatuses ?? this.nextStatuses,
      createdAt: createdAt,
      rejectionReason: rejectionReason,
    );
  }

  @override
  List<Object?> get props => [id, code, status, total, nextStatuses];
}
