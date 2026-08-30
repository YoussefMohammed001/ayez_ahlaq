import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../crash_reporting/vso_crash_reporting_manager.dart';
import '../helpers/safe_print.dart';
import '../di/services_locator.dart';
import 'remote_config_service.dart';
import 'update_dialog_service.dart';
import 'navigation_service.dart';
import '../crash_reporting/crash_reporting_keys.dart';

class VersionChecker {
  final BuildContext context;
  final IRemoteConfigService remoteConfigService;
  final CupertinoUpdateDialogService updateDialogService;
  final AuthNavigationService navigationService;

  VersionChecker({
    required this.context,
    required this.remoteConfigService,
    required this.updateDialogService,
    required this.navigationService,
  });

  Future<void> checkAppVersion() async {
    try {
      final remoteValues = await remoteConfigService.fetchConfig();
      final packageInfo = await PackageInfo.fromPlatform();

      final currentVersionCode = int.tryParse(packageInfo.buildNumber) ?? 0;
      final latestVersionCode = Platform.isAndroid
          ? int.tryParse(remoteValues.androidVersion) ?? 0
          : int.tryParse(remoteValues.iosVersion) ?? 0;

      sl<VSOCrashReportingManager>().setCrashReportingKeyWithEnumKey(
        CrashReportingKey.appVersion,
        Platform.isAndroid
            ? "Android ${packageInfo.version}"
            : "iOS ${packageInfo.version}",
      );

      final updateRequired = currentVersionCode < latestVersionCode;

      if (updateRequired) {
        final isCritical = Platform.isAndroid
            ? remoteValues.isCriticalAndroid
            : remoteValues.isCriticalIos;

        updateDialogService.showUpdateDialog(
          context,
          isCritical: isCritical,
          onUpdate: _launchStore,
          onSkip: navigationService.navigate,
        );
      } else {
        navigationService.navigate();
      }
    } catch (e) {
      safePrint("Remote config failed: $e");
      navigationService.navigate();
    }
  }

  void _launchStore() {
    final url = Platform.isAndroid
        ? "https://play.google.com/store/apps/details?id=com.cic.tmg.ksa.eservice"
        : "https://apps.apple.com/eg/app/tmgsa/id6748066824";
    launchUrl(Uri.parse(url));
  }
}
