import '../../domain/entities/shop.dart';

class ShopModel extends Shop {
  const ShopModel({
    required super.id,
    required super.name,
    super.address,
    super.distanceKm,
    required super.favorite,
    required super.rating,
    required super.ratingCount,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      address: json['address'] as String?,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      favorite: json['favorite'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
    );
  }
}
