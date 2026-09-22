import 'package:equatable/equatable.dart';

class MerchantProfile extends Equatable {
  final int id;
  final String businessName;
  final String ownerName;
  final String phoneNumber;
  final String? phoneE164;
  final String? email;
  final String? userName;
  final bool active;
  final bool mustChangePassword;
  final int categoryLimit;
  final int? zoneId;
  final String? zoneName;
  final DateTime? createdAt;
  final double? latitude;
  final double? longitude;
  final String? address;

  const MerchantProfile({
    required this.id,
    required this.businessName,
    required this.ownerName,
    required this.phoneNumber,
    required this.active,
    required this.mustChangePassword,
    required this.categoryLimit,
    this.phoneE164,
    this.email,
    this.userName,
    this.zoneId,
    this.zoneName,
    this.createdAt,
    this.latitude,
    this.longitude,
    this.address,
  });

  bool get needsLocation => latitude == null || longitude == null;

  @override
  List<Object?> get props => [
    id,
    businessName,
    ownerName,
    phoneNumber,
    phoneE164,
    email,
    userName,
    active,
    mustChangePassword,
    categoryLimit,
    zoneId,
    zoneName,
    createdAt,
    latitude,
    longitude,
    address,
  ];
}
