import '../../domain/entities/barber_permissions.dart';
import '../../domain/entities/barber_profile.dart';

class BarberProfileModel extends BarberProfile {
  const BarberProfileModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.shopId,
    required super.shopName,
    required super.owner,
    super.permissions,
    required super.active,
    required super.servesClients,
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
      permissions: permissionsFrom(json['permissions']),
      active: json['active'] as bool? ?? false,
      servesClients: json['servesClients'] as bool? ?? true,
      mustChangePassword: json['mustChangePassword'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  static BarberPermissions permissionsFrom(dynamic json) {
    if (json is! Map<String, dynamic>) return BarberPermissions.none;
    return BarberPermissions(
      canViewRevenue: json['canViewRevenue'] as bool? ?? false,
      canCloseBookings: json['canCloseBookings'] as bool? ?? false,
      canMarkPaid: json['canMarkPaid'] as bool? ?? false,
    );
  }
}
