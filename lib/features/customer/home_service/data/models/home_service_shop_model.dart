import '../../domain/entities/home_service_shop.dart';

class HomeServiceShopModel extends HomeServiceShop {
  const HomeServiceShopModel({
    required super.id,
    required super.name,
    super.area,
    super.address,
    required super.latitude,
    required super.longitude,
    required super.rating,
    required super.ratingCount,
    super.distanceKm,
    required super.favorite,
    required super.sponsored,
    required super.homeServicePrice,
    super.homeServiceNote,
    required super.hasProfileImage,
  });

  factory HomeServiceShopModel.fromJson(Map<String, dynamic> json) {
    return HomeServiceShopModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      area: json['area'] as String?,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      favorite: json['favorite'] as bool? ?? false,
      sponsored: json['sponsored'] as bool? ?? false,
      homeServicePrice: json['homeServicePrice'] as num? ?? 0,
      homeServiceNote: json['homeServiceNote'] as String?,
      hasProfileImage: json['hasProfileImage'] as bool? ?? false,
    );
  }
}
