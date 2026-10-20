import '../../domain/entities/store_feed_product.dart';

class StoreFeedProductModel extends StoreFeedProduct {
  const StoreFeedProductModel({
    required super.id,
    required super.name,
    super.brand,
    required super.price,
    required super.effectivePrice,
    required super.inStock,
    required super.rating,
    required super.minOrderQty,
    required super.merchantId,
    required super.merchantName,
    required super.merchantRating,
    super.distanceKm,
    required super.deliveryOffered,
    super.badges,
    super.hasImage,
  });

  factory StoreFeedProductModel.fromJson(Map<String, dynamic> json) {
    final price = (json['price'] as num?)?.toInt() ?? 0;
    return StoreFeedProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      brand: json['brand'] as String?,
      price: price,
      effectivePrice: (json['effectivePrice'] as num?)?.toInt() ?? price,
      inStock: json['inStock'] as bool? ?? true,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      minOrderQty: (json['minOrderQty'] as num?)?.toInt() ?? 1,
      merchantId: (json['merchantId'] as num?)?.toInt() ?? 0,
      merchantName: json['merchantName'] as String? ?? '',
      merchantRating: (json['merchantRating'] as num?)?.toDouble() ?? 0,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      deliveryOffered: json['deliveryOffered'] as bool? ?? false,
      badges:
          (json['badges'] as List?)?.map((e) => e as String).toList() ??
          const [],
      hasImage:
          json['hasOwnImage'] as bool? ?? json['hasImage'] as bool? ?? true,
    );
  }
}
