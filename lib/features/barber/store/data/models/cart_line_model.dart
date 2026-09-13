import '../../domain/entities/cart_line.dart';

class CartLineModel extends CartLine {
  const CartLineModel({
    required super.productId,
    required super.productName,
    required super.quantity,
    required super.unitPrice,
    required super.unitDiscount,
    required super.netUnitPrice,
    required super.lineTotal,
    required super.minOrderQty,
    required super.available,
    super.unavailableReason,
  });

  factory CartLineModel.fromJson(Map<String, dynamic> json) {
    return CartLineModel(
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      productName: json['productName'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toInt() ?? 0,
      unitDiscount: (json['unitDiscount'] as num?)?.toInt() ?? 0,
      netUnitPrice: (json['netUnitPrice'] as num?)?.toInt() ?? 0,
      lineTotal: (json['lineTotal'] as num?)?.toInt() ?? 0,
      minOrderQty: (json['minOrderQty'] as num?)?.toInt() ?? 1,
      available: json['available'] as bool? ?? true,
      unavailableReason: json['unavailableReason'] as String?,
    );
  }
}
