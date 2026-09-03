import '../../domain/entities/barber_profile.dart';

class BarberProfileModel extends BarberProfile {
  const BarberProfileModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.shopId,
    required super.shopName,
    required super.owner,
    required super.active,
    required super.mustChangePassword,
    required super.rating,
    required super.ratingCount,
    super.address,
    super.latitude,
    super.longitude,
  });

  factory BarberProfileModel.fromJson(Map<String, dynamic> json) {
    return BarberProfileModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      shopId: (json['shopId'] as num?)?.toInt() ?? 0,
      shopName: json['shopName'] as String? ?? '',
      owner: json['owner'] as bool? ?? false,
      active: json['active'] as bool? ?? false,
      mustChangePassword: json['mustChangePassword'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }
}
