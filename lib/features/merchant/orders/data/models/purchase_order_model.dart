import '../../domain/entities/fulfilment_type.dart';
import '../../domain/entities/order_status.dart';
import '../../domain/entities/purchase_order.dart';
import 'order_item_model.dart';

class PurchaseOrderModel extends PurchaseOrder {
  const PurchaseOrderModel({
    required super.id,
    required super.code,
    required super.shopName,
    required super.barberName,
    required super.items,
    required super.subtotal,
    required super.orderDiscount,
    required super.total,
    required super.status,
    required super.fulfilmentType,
    required super.nextStatuses,
    super.createdAt,
    super.rejectionReason,
  });

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List?) ?? const [];
    final next = (json['nextStatuses'] as List?) ?? const [];
    final total = (json['total'] as num?)?.toInt() ?? 0;

    return PurchaseOrderModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: json['code'] as String? ?? '#${json['id'] ?? ''}',
      shopName: json['shopName'] as String? ?? json['shop']?['name'] as String? ?? '',
      barberName:
          json['barberName'] as String? ?? json['barber']?['name'] as String? ?? '',
      items: items
          .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtotal: (json['subtotal'] as num?)?.toInt() ?? total,
      orderDiscount: (json['orderDiscount'] as num?)?.toInt() ?? 0,
      total: total,
      status: OrderStatus.fromApi(json['status'] as String?),
      fulfilmentType: FulfilmentType.fromApi(json['fulfilmentType'] as String?),
      nextStatuses:
          next.map((e) => OrderStatus.fromApi(e as String?)).toList(),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      rejectionReason: json['rejectionReason'] as String?,
    );
  }
}
