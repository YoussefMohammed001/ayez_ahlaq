import 'package:equatable/equatable.dart';
import '../../../../../shared/location/domain/entities/geo_point.dart';

class Shop extends Equatable {
  final int id;
  final String name;
  final String? address;
  final double? distanceKm;
  final double? latitude;
  final double? longitude;
  final bool favorite;
  final bool sponsored;
  final double rating;
  final int ratingCount;
  final bool hasProfileImage;

  const Shop({
    required this.id,
    required this.name,
    this.address,
    this.distanceKm,
    this.latitude,
    this.longitude,
    required this.favorite,
    this.sponsored = false,
    required this.rating,
    required this.ratingCount,
    this.hasProfileImage = false,
  });

  GeoPoint? get location {
    final lat = latitude;
    final lng = longitude;
    if (lat == null || lng == null || (lat == 0 && lng == 0)) return null;
    return GeoPoint(lat, lng);
  }

  Shop withDistanceFrom(GeoPoint origin) {
    final target = location;
    if (distanceKm != null || target == null) return this;

    return Shop(
      id: id,
      name: name,
      address: address,
      distanceKm: origin.distanceKmTo(target),
      latitude: latitude,
      longitude: longitude,
      favorite: favorite,
      sponsored: sponsored,
      rating: rating,
      ratingCount: ratingCount,
      hasProfileImage: hasProfileImage,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    address,
    distanceKm,
    latitude,
    longitude,
    favorite,
    sponsored,
    rating,
    ratingCount,
    hasProfileImage,
  ];
}
