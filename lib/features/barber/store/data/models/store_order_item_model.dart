import '../../domain/entities/store_order_item.dart';

class StoreOrderItemModel extends StoreOrderItem {
  const StoreOrderItemModel({
    required super.productId,
    required super.productName,
    required super.quantity,
    required super.unitPrice,
    required super.lineTotal,
  });

  factory StoreOrderItemModel.fromJson(Map<String, dynamic> json) {
    return StoreOrderItemModel(
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      productName:
          json['productName'] as String? ?? json['name'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toInt() ?? 0,
      lineTotal: (json['lineTotal'] as num?)?.toInt() ?? 0,
    );
  }
}
