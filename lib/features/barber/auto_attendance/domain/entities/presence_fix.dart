import 'package:equatable/equatable.dart';
import '../../../../../shared/location/domain/entities/geo_point.dart';

class PresenceFix extends Equatable {
  final double latitude;
  final double longitude;
  final double accuracyMeters;

  const PresenceFix({
    required this.latitude,
    required this.longitude,
    required this.accuracyMeters,
  });

  double metersTo(double lat, double lng) =>
      GeoPoint(latitude, longitude).distanceKmTo(GeoPoint(lat, lng)) * 1000;

  @override
  List<Object?> get props => [latitude, longitude, accuracyMeters];
}
