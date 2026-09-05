import 'package:equatable/equatable.dart';

class ShopBarberService extends Equatable {
  final int id;
  final String name;
  final int price;
  final int durationMinutes;

  const ShopBarberService({
    required this.id,
    required this.name,
    required this.price,
    required this.durationMinutes,
  });

  @override
  List<Object?> get props => [id, name, price, durationMinutes];
}

class ShopBarber extends Equatable {
  final int id;
  final String name;
  final double rating;
  final int ratingCount;
  final bool favorite;
  final bool viaInvite;
  final bool owner;
  final List<ShopBarberService> services;

  const ShopBarber({
    required this.id,
    required this.name,
    required this.rating,
    required this.ratingCount,
    required this.favorite,
    required this.viaInvite,
    required this.owner,
    required this.services,
  });

  ShopBarber copyWith({bool? favorite}) {
    return ShopBarber(
      id: id,
      name: name,
      rating: rating,
      ratingCount: ratingCount,
      favorite: favorite ?? this.favorite,
      viaInvite: viaInvite,
      owner: owner,
      services: services,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    rating,
    ratingCount,
    favorite,
    viaInvite,
    owner,
    services,
  ];
}
