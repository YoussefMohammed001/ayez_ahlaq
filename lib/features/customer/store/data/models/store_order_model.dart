import '../../domain/entities/store_fulfillment_type.dart';
import '../../domain/entities/store_order.dart';
import '../../domain/entities/store_order_status.dart';
import 'store_quote_line_model.dart';

class StoreOrderModel extends StoreOrder {
  const StoreOrderModel({
    required super.id,
    required super.code,
    required super.status,
    required super.shopId,
    required super.shopName,
    required super.fulfillmentType,
    required super.paymentMethod,
    required super.subtotal,
    required super.deliveryFee,
    required super.total,
    required super.items,
    super.note,
    super.createdAt,
    super.rejectionReason,
  });

  factory StoreOrderModel.fromJson(Map<String, dynamic> json) {
    return StoreOrderModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: json['code'] as String? ?? '#${json['id'] ?? ''}',
      status: StoreOrderStatus.fromApi(json['status'] as String?),
      shopId: (json['shopId'] as num?)?.toInt() ?? 0,
      shopName: json['shopName'] as String? ?? '',
      fulfillmentType: json['fulfillmentType'] == 'PICKUP_AT_BRANCH'
          ? StoreFulfillmentType.pickupAtBranch
          : StoreFulfillmentType.delivery,
      paymentMethod: json['paymentMethod'] as String? ?? '',
      subtotal: (json['subtotal'] as num?)?.toInt() ?? 0,
      deliveryFee: (json['deliveryFee'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => StoreQuoteLineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      note: json['note'] as String?,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      rejectionReason: json['rejectionReason'] as String?,
    );
  }
}
