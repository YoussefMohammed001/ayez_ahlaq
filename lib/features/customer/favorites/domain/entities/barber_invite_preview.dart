import 'package:equatable/equatable.dart';

class BarberInvitePreview extends Equatable {
  final String code;
  final int barberId;
  final String barberName;
  final String? tagline;
  final int shopId;
  final String shopName;
  final String? area;
  final String? address;
  final double rating;
  final int ratingCount;

  const BarberInvitePreview({
    required this.code,
    required this.barberId,
    required this.barberName,
    required this.shopId,
    required this.shopName,
    required this.rating,
    required this.ratingCount,
    this.tagline,
    this.area,
    this.address,
  });

  @override
  List<Object?> get props => [
    code,
    barberId,
    barberName,
    tagline,
    shopId,
    shopName,
    area,
    address,
    rating,
    ratingCount,
  ];
}
