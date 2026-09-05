import 'package:equatable/equatable.dart';

class FavoriteBarber extends Equatable {
  final int barberId;
  final String barberName;
  final int shopId;
  final String shopName;
  final double rating;
  final int ratingCount;
  final bool viaInvite;
  final DateTime? since;

  const FavoriteBarber({
    required this.barberId,
    required this.barberName,
    required this.shopId,
    required this.shopName,
    required this.rating,
    required this.ratingCount,
    required this.viaInvite,
    this.since,
  });

  @override
  List<Object?> get props => [
    barberId,
    barberName,
    shopId,
    shopName,
    rating,
    ratingCount,
    viaInvite,
    since,
  ];
}
