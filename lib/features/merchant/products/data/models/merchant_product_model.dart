import '../../domain/entities/merchant_product.dart';
import '../../domain/entities/product_image_source.dart';
import 'active_discount_model.dart';

class MerchantProductModel extends MerchantProduct {
  const MerchantProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.effectivePrice,
    required super.minOrderQty,
    required super.active,
    required super.totalStock,
    required super.imageSource,
    required super.imageIds,
    super.brand,
    super.categoryId,
    super.categoryName,
    super.description,
    super.activeDiscount,
  });

  factory MerchantProductModel.fromJson(Map<String, dynamic> json) {
    final price = (json['price'] as num?)?.toInt() ?? 0;
    final discount = json['activeDiscount'];

    return MerchantProductModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      brand: json['brand'] as String?,
      categoryId: json['categoryId'] as int?,
      categoryName: json['categoryName'] as String?,
      description: json['description'] as String?,
      price: price,
      effectivePrice: (json['effectivePrice'] as num?)?.toInt() ?? price,
      minOrderQty: (json['minOrderQty'] as num?)?.toInt() ?? 1,
      active: json['active'] as bool? ?? true,
      totalStock: (json['totalStock'] as num?)?.toInt() ?? 0,
      activeDiscount: discount is Map<String, dynamic>
          ? ActiveDiscountModel.fromJson(discount)
          : null,
      imageSource: ProductImageSource.fromApi(json['imageSource'] as String?),
      imageIds:
          (json['imageIds'] as List?)?.map((e) => e as int).toList() ?? const [],
    );
  }
}
