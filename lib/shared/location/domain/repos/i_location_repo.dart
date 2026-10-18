import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/device_location_result.dart';
import '../entities/geo_point.dart';
import '../entities/location_availability.dart';
import '../entities/place_info.dart';
import '../entities/place_suggestion.dart';

abstract class ILocationRepo {
  Future<LocationAvailability> availability();

  Future<DeviceLocationResult> currentLocation({
    required bool requestPermission,
  });

  Future<void> openSettings(LocationAvailability availability);

  Future<bool> openInMaps(GeoPoint point);

  Future<String?> governorateOf(GeoPoint point);

  Future<Either<Failure, PlaceInfo>> placeOf(GeoPoint point);

  Future<Either<Failure, List<PlaceSuggestion>>> search(String query);
}
