import '../../domain/entities/favorite_barber.dart';

class FavoriteBarberModel extends FavoriteBarber {
  const FavoriteBarberModel({
    required super.barberId,
    required super.barberName,
    required super.shopId,
    required super.shopName,
    required super.rating,
    required super.ratingCount,
    required super.viaInvite,
    super.since,
  });

  factory FavoriteBarberModel.fromJson(Map<String, dynamic> json) {
    return FavoriteBarberModel(
      barberId: (json['barberId'] as num?)?.toInt() ?? 0,
      barberName: json['barberName'] as String? ?? '',
      shopId: (json['shopId'] as num?)?.toInt() ?? 0,
      shopName: json['shopName'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
      viaInvite: json['viaInvite'] as bool? ?? false,
      since: DateTime.tryParse(json['since'] as String? ?? ''),
    );
  }
}
