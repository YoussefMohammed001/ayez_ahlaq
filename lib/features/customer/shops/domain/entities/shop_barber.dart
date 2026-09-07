import 'package:equatable/equatable.dart';

class ShopBarberService extends Equatable {
  final int barberServiceId;
  final int serviceTypeId;
  final String name;
  final String? description;
  final int price;
  final int durationMinutes;
  final bool popular;

  const ShopBarberService({
    required this.barberServiceId,
    required this.serviceTypeId,
    required this.name,
    required this.price,
    required this.durationMinutes,
    this.description,
    this.popular = false,
  });

  @override
  List<Object?> get props => [
    barberServiceId,
    serviceTypeId,
    name,
    description,
    price,
    durationMinutes,
    popular,
  ];
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
