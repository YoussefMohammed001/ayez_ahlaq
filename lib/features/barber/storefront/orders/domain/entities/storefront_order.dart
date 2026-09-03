import 'package:equatable/equatable.dart';
import 'storefront_fulfillment_type.dart';
import 'storefront_order_item.dart';
import 'storefront_order_status.dart';

class StorefrontOrder extends Equatable {
  final int id;
  final String code;
  final StorefrontOrderStatus status;
  final String customerName;
  final String customerPhone;
  final StorefrontFulfillmentType fulfillmentType;
  final String paymentMethod;
  final int subtotal;
  final int deliveryFee;
  final int total;
  final List<StorefrontOrderItem> items;
  final List<StorefrontOrderStatus> nextStatuses;
  final DateTime? createdAt;
  final String? rejectionReason;

  const StorefrontOrder({
    required this.id,
    required this.code,
    required this.status,
    required this.customerName,
    required this.customerPhone,
    required this.fulfillmentType,
    required this.paymentMethod,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.items,
    required this.nextStatuses,
    this.createdAt,
    this.rejectionReason,
  });

  bool get canAdvance => nextStatuses.isNotEmpty;

  bool get hasDeliveryFee => deliveryFee > 0;

  StorefrontOrder copyWith({
    StorefrontOrderStatus? status,
    List<StorefrontOrderStatus>? nextStatuses,
  }) {
    return StorefrontOrder(
      id: id,
      code: code,
      status: status ?? this.status,
      customerName: customerName,
      customerPhone: customerPhone,
      fulfillmentType: fulfillmentType,
      paymentMethod: paymentMethod,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: total,
      items: items,
      nextStatuses: nextStatuses ?? this.nextStatuses,
      createdAt: createdAt,
      rejectionReason: rejectionReason,
    );
  }

  @override
  List<Object?> get props => [id, code, status, total, nextStatuses];
}
