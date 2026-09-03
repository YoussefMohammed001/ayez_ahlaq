import '../../domain/entities/storefront_fulfillment_type.dart';
import '../../domain/entities/storefront_order.dart';
import '../../domain/entities/storefront_order_status.dart';
import 'storefront_order_item_model.dart';

class StorefrontOrderModel extends StorefrontOrder {
  const StorefrontOrderModel({
    required super.id,
    required super.code,
    required super.status,
    required super.customerName,
    required super.customerPhone,
    required super.fulfillmentType,
    required super.paymentMethod,
    required super.subtotal,
    required super.deliveryFee,
    required super.total,
    required super.items,
    required super.nextStatuses,
    super.createdAt,
    super.rejectionReason,
  });

  factory StorefrontOrderModel.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List?) ?? const [];
    final next = (json['nextStatuses'] as List?) ?? const [];
    final subtotal = (json['subtotal'] as num?)?.toInt() ?? 0;
    final deliveryFee = (json['deliveryFee'] as num?)?.toInt() ?? 0;

    return StorefrontOrderModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: json['code'] as String? ?? '#${json['id'] ?? ''}',
      status: StorefrontOrderStatus.fromApi(json['status'] as String?),
      customerName: json['customerName'] as String? ?? '',
      customerPhone: json['customerPhone'] as String? ?? '',
      fulfillmentType: StorefrontFulfillmentType.fromApi(
        json['fulfillmentType'] as String?,
      ),
      paymentMethod: json['paymentMethod'] as String? ?? '',
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: (json['total'] as num?)?.toInt() ?? subtotal + deliveryFee,
      items: items
          .map(
            (e) => StorefrontOrderItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      nextStatuses: next
          .map((e) => StorefrontOrderStatus.fromApi(e as String?))
          .toList(),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      rejectionReason: json['rejectionReason'] as String?,
    );
  }
}
