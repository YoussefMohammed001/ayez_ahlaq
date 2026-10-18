import 'package:equatable/equatable.dart';
import 'barber_permissions.dart';

class BarberProfile extends Equatable {
  final int id;
  final String name;
  final String phoneNumber;
  final int shopId;
  final String shopName;
  final bool owner;
  final BarberPermissions permissions;
  final bool active;
  final bool servesClients;
  final bool mustChangePassword;
  final double rating;
  final int ratingCount;
  final String? address;
  final double? latitude;
  final double? longitude;

  const BarberProfile({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.shopId,
    required this.shopName,
    required this.owner,
    this.permissions = BarberPermissions.none,
    required this.active,
    required this.servesClients,
    required this.mustChangePassword,
    required this.rating,
    required this.ratingCount,
    this.address,
    this.latitude,
    this.longitude,
  });

  bool get isTeamMember => !owner;

  bool get needsLocation => owner && (latitude == null || longitude == null);

  bool get canViewRevenue => owner || permissions.canViewRevenue;

  bool get canCloseBookings => owner || permissions.canCloseBookings;

  bool get canMarkPaid => owner || permissions.canMarkPaid;

  @override
  List<Object?> get props => [
    id,
    name,
    phoneNumber,
    shopId,
    shopName,
    owner,
    permissions,
    active,
    servesClients,
    mustChangePassword,
    rating,
    ratingCount,
    address,
    latitude,
    longitude,
  ];
}
