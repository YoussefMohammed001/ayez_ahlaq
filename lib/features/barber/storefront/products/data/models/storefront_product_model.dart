import '../../domain/entities/storefront_product.dart';

class StorefrontProductModel extends StorefrontProduct {
  const StorefrontProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.minOrderQty,
    required super.active,
    required super.stock,
    required super.hasImage,
    super.brand,
    super.categoryId,
    super.categoryName,
    super.description,
  });

  factory StorefrontProductModel.fromJson(Map<String, dynamic> json) {
    return StorefrontProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      brand: json['brand'] as String?,
      categoryId: (json['categoryId'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toInt() ?? 0,
      minOrderQty: (json['minOrderQty'] as num?)?.toInt() ?? 1,
      active: json['active'] as bool? ?? true,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      hasImage: json['hasImage'] as bool? ?? false,
    );
  }
}
