import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/error/failure.dart';
import '../../../core/helpers/safe_print.dart';
import '../../../generated/l10n.dart';
import '../domain/entities/device_location_result.dart';
import '../domain/entities/geo_point.dart';
import '../domain/entities/location_availability.dart';
import '../domain/entities/place_info.dart';
import '../domain/entities/place_suggestion.dart';
import '../domain/repos/i_location_repo.dart';
import 'device_position_source.dart';
import 'external_maps_launcher.dart';
import 'place_geocoder.dart';
import 'placemark_mapper.dart';

class LocationRepo implements ILocationRepo {
  static const _maxSuggestions = 1;

  final DevicePositionSource _positionSource;
  final PlaceGeocoder _geocoder;
  final ExternalMapsLauncher _mapsLauncher;

  LocationRepo(this._positionSource, this._geocoder, this._mapsLauncher);

  @override
  Future<LocationAvailability> availability() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return LocationAvailability.serviceDisabled;
    }
    return _fromPermission(await Geolocator.checkPermission());
  }

  @override
  Future<DeviceLocationResult> currentLocation({
    required bool requestPermission,
  }) async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return const DeviceLocationResult(LocationAvailability.serviceDisabled);
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied && requestPermission) {
        permission = await Geolocator.requestPermission();
      }

      final status = _fromPermission(permission);
      if (!status.isAvailable) return DeviceLocationResult(status);

      final point = await _positionSource.resolve();
      if (point == null) {
        return const DeviceLocationResult(LocationAvailability.unavailable);
      }
      return DeviceLocationResult(LocationAvailability.available, point);
    } catch (_) {
      return const DeviceLocationResult(LocationAvailability.unavailable);
    }
  }

  @override
  Future<void> openSettings(LocationAvailability availability) async {
    if (availability == LocationAvailability.serviceDisabled) {
      await Geolocator.openLocationSettings();
      return;
    }
    await Geolocator.openAppSettings();
  }

  @override
  Future<String?> governorateOf(GeoPoint point) =>
      _geocoder.governorateOf(point);

  @override
  Future<bool> openInMaps(GeoPoint point) async {
    try {
      return await _mapsLauncher.openInGoogleMaps(point);
    } catch (_) {
      return false;
    }
  }

  @override
  Future<Either<Failure, PlaceInfo>> placeOf(GeoPoint point) async {
    try {
      final places = await _geocoder.placemarksOf(point);
      if (places.isEmpty) return const Right(PlaceInfo.empty);
      return Right(PlacemarkMapper.toPlaceInfo(places.first));
    } catch (error) {
      safePrint('placeOf failed: $error');
      return Left(Failure(S().somethingWentWrong, null, {}));
    }
  }

  @override
  Future<Either<Failure, List<PlaceSuggestion>>> search(String query) async {
    try {
      final points = await _geocoder.pointsOf(query, limit: _maxSuggestions);
      return Right(await Future.wait(points.map(_toSuggestion)));
    } catch (_) {
      return const Right([]);
    }
  }

  Future<PlaceSuggestion> _toSuggestion(GeoPoint point) async {
    final info = (await placeOf(point)).getOrElse(() => PlaceInfo.empty);
    return PlaceSuggestion(point: point, info: info);
  }

  LocationAvailability _fromPermission(LocationPermission permission) {
    switch (permission) {
      case LocationPermission.denied:
        return LocationAvailability.permissionDenied;
      case LocationPermission.deniedForever:
        return LocationAvailability.permissionDeniedForever;
      default:
        return LocationAvailability.available;
    }
  }
}
