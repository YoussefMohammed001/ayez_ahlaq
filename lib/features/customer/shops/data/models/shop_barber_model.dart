import '../../domain/entities/shop_barber.dart';

class ShopBarberServiceModel extends ShopBarberService {
  const ShopBarberServiceModel({
    required super.id,
    required super.name,
    required super.price,
    required super.durationMinutes,
  });

  factory ShopBarberServiceModel.fromJson(Map<String, dynamic> json) {
    return ShopBarberServiceModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 0,
    );
  }
}

class ShopBarberModel extends ShopBarber {
  const ShopBarberModel({
    required super.id,
    required super.name,
    required super.rating,
    required super.ratingCount,
    required super.favorite,
    required super.viaInvite,
    required super.owner,
    required super.services,
  });

  factory ShopBarberModel.fromJson(Map<String, dynamic> json) {
    return ShopBarberModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
      favorite: json['favorite'] as bool? ?? false,
      viaInvite: json['viaInvite'] as bool? ?? false,
      owner: json['owner'] as bool? ?? false,
      services: (json['services'] as List<dynamic>? ?? [])
          .map((e) => ShopBarberServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
