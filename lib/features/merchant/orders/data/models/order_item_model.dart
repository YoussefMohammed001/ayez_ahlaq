import '../../domain/entities/order_item.dart';

class OrderItemModel extends OrderItem {
  const OrderItemModel({
    required super.productId,
    required super.productName,
    required super.quantity,
    required super.unitPrice,
    required super.unitDiscount,
    required super.lineTotal,
    super.gift,
    super.currentEffectivePrice,
    super.priceChangedSinceOrder,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      productName: json['productName'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toInt() ?? 0,
      unitDiscount: (json['unitDiscount'] as num?)?.toInt() ?? 0,
      lineTotal: (json['lineTotal'] as num?)?.toInt() ?? 0,
      gift: json['gift'] as bool? ?? false,
      currentEffectivePrice: (json['currentEffectivePrice'] as num?)?.toInt(),
      priceChangedSinceOrder: json['priceChangedSinceOrder'] as bool? ?? false,
    );
  }
}
