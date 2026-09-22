import 'package:geolocator/geolocator.dart';

class CurrentPositionResolver {
  static const _timeout = Duration(seconds: 8);

  Future<Position?> resolve() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(timeLimit: _timeout),
      ).timeout(_timeout);
    } catch (_) {
      return null;
    }
  }
}
