import 'dart:io';
import 'package:native_geofence/native_geofence.dart';
import '../../../../../core/helpers/safe_print.dart';

class ForegroundPromotion {
  const ForegroundPromotion._();

  static Future<void> promote() async {
    if (!Platform.isAndroid) return;
    try {
      await NativeGeofenceBackgroundManager.instance.promoteToForeground();
    } catch (error) {
      safePrint('Could not promote to foreground: $error');
    }
  }

  static Future<void> demote() async {
    if (!Platform.isAndroid) return;
    try {
      await NativeGeofenceBackgroundManager.instance.demoteToBackground();
    } catch (_) {}
  }
}
