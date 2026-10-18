import 'dart:math';
import 'package:equatable/equatable.dart';

class GeoPoint extends Equatable {
  static const _earthRadiusKm = 6371.0;

  final double latitude;
  final double longitude;

  const GeoPoint(this.latitude, this.longitude);

  double distanceKmTo(GeoPoint other) {
    final latDelta = _radians(other.latitude - latitude);
    final lngDelta = _radians(other.longitude - longitude);
    final a =
        pow(sin(latDelta / 2), 2) +
        cos(_radians(latitude)) *
            cos(_radians(other.latitude)) *
            pow(sin(lngDelta / 2), 2);
    return 2 * _earthRadiusKm * asin(sqrt(a));
  }

  double _radians(double degrees) => degrees * pi / 180;

  @override
  List<Object?> get props => [latitude, longitude];
}
