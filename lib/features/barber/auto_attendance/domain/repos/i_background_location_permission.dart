import '../entities/background_location_status.dart';

abstract class IBackgroundLocationPermission {
  Future<BackgroundLocationStatus> status();

  Future<BackgroundLocationStatus> request();

  Future<void> openSettings();
}
