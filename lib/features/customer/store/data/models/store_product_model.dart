import '../../domain/entities/store_product.dart';

class StoreProductModel extends StoreProduct {
  const StoreProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.effectivePrice,
    required super.minOrderQty,
    required super.stock,
    required super.hasImage,
    super.brand,
    super.categoryId,
    super.categoryName,
    super.description,
  });

  factory StoreProductModel.fromJson(Map<String, dynamic> json) {
    final price = (json['price'] as num?)?.toInt() ?? 0;
    return StoreProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      brand: json['brand'] as String?,
      categoryId: (json['categoryId'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String?,
      description: json['description'] as String?,
      price: price,
      effectivePrice: (json['effectivePrice'] as num?)?.toInt() ?? price,
      minOrderQty: (json['minOrderQty'] as num?)?.toInt() ?? 1,
      stock: (json['totalStock'] as num?)?.toInt() ??
          (json['stock'] as num?)?.toInt() ??
          0,
      hasImage:
          json['hasOwnImage'] as bool? ?? json['hasImage'] as bool? ?? false,
    );
  }
}
