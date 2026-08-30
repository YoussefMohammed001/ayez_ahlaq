import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ayez_ahlaq/core/helpers/notification_service.dart';
import 'package:ayez_ahlaq/core/helpers/safe_print.dart';
import '../cache/preferences_storage/preferences_storage.dart';
import '../cache/preferences_storage/preferences_storage_keys.dart';
import '../cache/secure_storage/secure_storage.dart';
import '../di/services_locator.dart';
import '../routes/route_paths.dart';

class AuthNavigationService {
  final BuildContext context;

  AuthNavigationService(this.context);

  Future<void> navigate() async {
    final token =
        await sl<SecureStorage>().read(SecureStorageKeys.userToken) ?? "";
    safePrint("navigation services (token) ===> $token");
    if (!context.mounted) return;

    // final hasStoredUser = sl<PreferencesStorage>()
    //     .getString(key: PreferencesKeys.userType)
    //     .isNotEmpty;

    if (token.isEmpty) {
      context.pushReplacement(Routes.userTypeScreen);
      return;
    }


    final mustChangePassword = sl<PreferencesStorage>().getBoolean(
      key: PreferencesKeys.userMustChangePassword,
    );
    if (!context.mounted) return;
    if (mustChangePassword) {
      context.pushReplacement(Routes.forceChangePasswordScreen);
      return;
    }

    if (!context.mounted) return;




    if (!context.mounted) return;

    _routePendingNotification();
  }

  void _routePendingNotification() {
    final message = sl<NotificationNavigator>().consumePendingInitialMessage();
    if (message == null) return;
    //sl<NotificationService>().handleNotificationTap(message);
  }
}
