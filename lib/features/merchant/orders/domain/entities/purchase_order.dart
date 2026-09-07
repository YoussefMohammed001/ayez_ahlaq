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
  final int deliveryFee;
  final int grandTotal;
  final OrderStatus status;
  final FulfilmentType fulfilmentType;
  final List<OrderStatus> nextStatuses;
  final DateTime? createdAt;
  final DateTime? orderDate;
  final DateTime? acceptedAt;
  final DateTime? rejectedAt;
  final DateTime? deliveredAt;
  final DateTime? cancelledAt;
  final String? rejectionReason;
  final String? cancellationNote;
  final String? cancelledByAdminName;
  final String? note;
  final String? deliveryAddress;
  final double? deliveryLat;
  final double? deliveryLng;

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
    required this.deliveryFee,
    required this.grandTotal,
    this.createdAt,
    this.orderDate,
    this.acceptedAt,
    this.rejectedAt,
    this.deliveredAt,
    this.cancelledAt,
    this.rejectionReason,
    this.cancellationNote,
    this.cancelledByAdminName,
    this.note,
    this.deliveryAddress,
    this.deliveryLat,
    this.deliveryLng,
  });

  List<OrderStatus> get validNextStatuses =>
      nextStatuses.where((s) => s.isValidFor(fulfilmentType)).toList();

  bool get canAdvance => validNextStatuses.isNotEmpty;

  bool get hasDeliveryFee => deliveryFee > 0;

  bool get hasDeliveryLocation => deliveryLat != null && deliveryLng != null;

  int get preDiscountTotal => total + orderDiscount;

  int? get orderDiscountPercent => preDiscountTotal > 0
      ? ((orderDiscount / preDiscountTotal) * 100).round()
      : null;

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
      deliveryFee: deliveryFee,
      grandTotal: grandTotal,
      status: status ?? this.status,
      fulfilmentType: fulfilmentType,
      nextStatuses: nextStatuses ?? this.nextStatuses,
      createdAt: createdAt,
      orderDate: orderDate,
      acceptedAt: acceptedAt,
      rejectedAt: rejectedAt,
      deliveredAt: deliveredAt,
      cancelledAt: cancelledAt,
      rejectionReason: rejectionReason,
      cancellationNote: cancellationNote,
      cancelledByAdminName: cancelledByAdminName,
      note: note,
      deliveryAddress: deliveryAddress,
      deliveryLat: deliveryLat,
      deliveryLng: deliveryLng,
    );
  }

  @override
  List<Object?> get props => [id, code, status, total, nextStatuses];
}
