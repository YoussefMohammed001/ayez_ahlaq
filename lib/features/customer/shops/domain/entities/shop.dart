import 'package:equatable/equatable.dart';

class Shop extends Equatable {
  final int id;
  final String name;
  final String? address;
  final double? distanceKm;
  final bool favorite;
  final double rating;
  final int ratingCount;

  const Shop({
    required this.id,
    required this.name,
    this.address,
    this.distanceKm,
    required this.favorite,
    required this.rating,
    required this.ratingCount,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    address,
    distanceKm,
    favorite,
    rating,
    ratingCount,
  ];
}
