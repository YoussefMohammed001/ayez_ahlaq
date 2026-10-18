import 'package:equatable/equatable.dart';
import '../../../../../shared/location/domain/entities/geo_point.dart';

class HomeServiceShop extends Equatable {
  final int id;
  final String name;
  final String? area;
  final String? address;
  final double latitude;
  final double longitude;
  final double rating;
  final int ratingCount;
  final double? distanceKm;
  final bool favorite;
  final bool sponsored;
  final num homeServicePrice;
  final String? homeServiceNote;
  final bool hasProfileImage;

  const HomeServiceShop({
    required this.id,
    required this.name,
    this.area,
    this.address,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.ratingCount,
    this.distanceKm,
    required this.favorite,
    required this.sponsored,
    required this.homeServicePrice,
    this.homeServiceNote,
    required this.hasProfileImage,
  });

  bool get hasCoordinates => latitude != 0 || longitude != 0;

  HomeServiceShop withDistanceFrom(GeoPoint origin) {
    if (distanceKm != null || !hasCoordinates) return this;

    return HomeServiceShop(
      id: id,
      name: name,
      area: area,
      address: address,
      latitude: latitude,
      longitude: longitude,
      rating: rating,
      ratingCount: ratingCount,
      distanceKm: origin.distanceKmTo(GeoPoint(latitude, longitude)),
      favorite: favorite,
      sponsored: sponsored,
      homeServicePrice: homeServicePrice,
      homeServiceNote: homeServiceNote,
      hasProfileImage: hasProfileImage,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    area,
    address,
    latitude,
    longitude,
    rating,
    ratingCount,
    distanceKm,
    favorite,
    sponsored,
    homeServicePrice,
    homeServiceNote,
    hasProfileImage,
  ];
}
