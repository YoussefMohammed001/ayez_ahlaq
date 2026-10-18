import '../../domain/entities/shop.dart';

class ShopModel extends Shop {
  const ShopModel({
    required super.id,
    required super.name,
    super.address,
    super.distanceKm,
    super.latitude,
    super.longitude,
    required super.favorite,
    super.sponsored,
    required super.rating,
    required super.ratingCount,
    super.hasProfileImage,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      address: json['address'] as String?,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      favorite: json['favorite'] as bool? ?? false,
      sponsored: json['sponsored'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      hasProfileImage: json['hasProfileImage'] as bool? ?? false,
    );
  }
}
