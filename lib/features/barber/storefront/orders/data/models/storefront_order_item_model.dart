import '../../domain/entities/storefront_order_item.dart';

class StorefrontOrderItemModel extends StorefrontOrderItem {
  const StorefrontOrderItemModel({
    required super.productId,
    required super.productName,
    required super.quantity,
    required super.unitPrice,
    required super.lineTotal,
  });

  factory StorefrontOrderItemModel.fromJson(Map<String, dynamic> json) {
    return StorefrontOrderItemModel(
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      productName: json['productName'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toInt() ?? 0,
      lineTotal: (json['lineTotal'] as num?)?.toInt() ?? 0,
    );
  }
}
