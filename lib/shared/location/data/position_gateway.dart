import 'package:geolocator/geolocator.dart';

abstract class PositionGateway {
  Future<Position?> current({required Duration timeLimit});

  Future<Position?> lastKnown();
}

class GeolocatorPositionGateway implements PositionGateway {
  @override
  Future<Position?> current({required Duration timeLimit}) =>
      Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: timeLimit,
        ),
      );

  @override
  Future<Position?> lastKnown() => Geolocator.getLastKnownPosition();
}
