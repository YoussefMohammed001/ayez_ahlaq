import '../../domain/entities/fulfillment_type.dart';
import '../../domain/entities/store_order.dart';
import '../../domain/entities/store_order_status.dart';
import 'store_order_item_model.dart';

class StoreOrderModel extends StoreOrder {
  const StoreOrderModel({
    required super.id,
    required super.code,
    required super.status,
    required super.merchantId,
    required super.merchantName,
    required super.fulfillmentType,
    required super.total,
    required super.orderDiscount,
    required super.deliveryFee,
    required super.grandTotal,
    required super.items,
    super.note,
    super.rejectionReason,
    super.orderDate,
  });

  factory StoreOrderModel.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List?) ?? const [];
    final total = (json['total'] as num?)?.toInt() ?? 0;
    final deliveryFee = (json['deliveryFee'] as num?)?.toInt() ?? 0;

    return StoreOrderModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: json['code'] as String? ?? '#${json['id'] ?? ''}',
      status: StoreOrderStatus.fromApi(json['status'] as String?),
      merchantId: (json['merchantId'] as num?)?.toInt() ?? 0,
      merchantName: json['merchantName'] as String? ?? '',
      fulfillmentType: FulfillmentType.fromApi(
        json['fulfillmentType'] as String?,
      ),
      total: total,
      orderDiscount: (json['orderDiscount'] as num?)?.toInt() ?? 0,
      deliveryFee: deliveryFee,
      grandTotal: (json['grandTotal'] as num?)?.toInt() ?? total + deliveryFee,
      items: items
          .map((e) => StoreOrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      note: json['note'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      orderDate: DateTime.tryParse(json['orderDate'] as String? ?? ''),
    );
  }
}
