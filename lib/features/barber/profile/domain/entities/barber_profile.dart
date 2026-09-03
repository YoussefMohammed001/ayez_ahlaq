import 'package:equatable/equatable.dart';

class BarberProfile extends Equatable {
  final int id;
  final String name;
  final String phoneNumber;
  final int shopId;
  final String shopName;
  final bool owner;
  final bool active;
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
    required this.active,
    required this.mustChangePassword,
    required this.rating,
    required this.ratingCount,
    this.address,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    phoneNumber,
    shopId,
    shopName,
    owner,
    active,
    rating,
    ratingCount,
  ];
}
