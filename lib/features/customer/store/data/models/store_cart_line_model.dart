import '../../domain/entities/store_cart_line.dart';

class StoreCartLineModel extends StoreCartLine {
  const StoreCartLineModel({
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

  factory StoreCartLineModel.fromJson(Map<String, dynamic> json) {
    final unitPrice = (json['unitPrice'] as num?)?.toInt() ?? 0;
    return StoreCartLineModel(
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      productName: json['productName'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: unitPrice,
      unitDiscount: (json['unitDiscount'] as num?)?.toInt() ?? 0,
      netUnitPrice: (json['netUnitPrice'] as num?)?.toInt() ?? unitPrice,
      lineTotal: (json['lineTotal'] as num?)?.toInt() ?? 0,
      minOrderQty: (json['minOrderQty'] as num?)?.toInt() ?? 1,
      available: json['available'] as bool? ?? true,
      unavailableReason: json['unavailableReason'] as String?,
    );
  }
}
