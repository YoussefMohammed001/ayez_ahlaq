import '../../domain/entities/store_product.dart';

class StoreProductModel extends StoreProduct {
  const StoreProductModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.categoryName,
    required super.price,
    required super.effectivePrice,
    required super.minOrderQty,
    required super.hasImage,
  });

  factory StoreProductModel.fromJson(Map<String, dynamic> json) {
    final price = (json['price'] as num?)?.toInt() ?? 0;
    return StoreProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      categoryName: json['categoryName'] as String? ?? '',
      price: price,
      effectivePrice: (json['effectivePrice'] as num?)?.toInt() ?? price,
      minOrderQty: (json['minOrderQty'] as num?)?.toInt() ?? 1,
      hasImage: json['hasImage'] as bool? ?? false,
    );
  }
}
