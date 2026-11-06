import 'package:permission_handler/permission_handler.dart';
import '../../domain/entities/background_location_status.dart';
import '../../domain/repos/i_background_location_permission.dart';

class PermissionHandlerBackgroundLocation
    implements IBackgroundLocationPermission {
  @override
  Future<BackgroundLocationStatus> status() => _read();

  @override
  Future<BackgroundLocationStatus> request() async {
    final foreground = await Permission.locationWhenInUse.request();
    if (foreground.isGranted) await Permission.locationAlways.request();
    return _read();
  }

  @override
  Future<void> openSettings() => openAppSettings();

  Future<BackgroundLocationStatus> _read() async {
    if (await Permission.locationAlways.isGranted) {
      return BackgroundLocationStatus.granted;
    }

    final foreground = await Permission.locationWhenInUse.status;
    if (foreground.isGranted) return BackgroundLocationStatus.whileInUseOnly;
    if (foreground.isPermanentlyDenied) return BackgroundLocationStatus.blocked;
    return BackgroundLocationStatus.denied;
  }
}
