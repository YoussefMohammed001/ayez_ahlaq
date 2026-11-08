import 'dart:io';
import 'package:geolocator/geolocator.dart';
import '../../domain/entities/presence_fix.dart';
import '../../domain/repos/i_presence_tracker.dart';

class GeolocatorPresenceTracker implements IPresenceTracker {
  static const Duration _androidInterval = Duration(seconds: 10);
  static const int _iosDistanceFilterMeters = 1;

  @override
  Stream<PresenceFix> fixes() =>
      Geolocator.getPositionStream(locationSettings: _settings).map(
        (position) => PresenceFix(
          latitude: position.latitude,
          longitude: position.longitude,
          accuracyMeters: position.accuracy,
        ),
      );

  LocationSettings get _settings => Platform.isIOS
      ? AppleSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: _iosDistanceFilterMeters,
          pauseLocationUpdatesAutomatically: false,
          showBackgroundLocationIndicator: true,
          allowBackgroundLocationUpdates: true,
        )
      : AndroidSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 0,
          intervalDuration: _androidInterval,
        );
}
