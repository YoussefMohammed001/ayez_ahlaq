import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/strings.dart';
import '../crash_reporting/crash_reporting_keys.dart';
import '../crash_reporting/crash_reporting_manager.dart';
import '../helpers/safe_print.dart';
import 'remote_config_service.dart';
import 'update_dialog_service.dart';
import 'update_status.dart';

class VersionChecker {
  final IRemoteConfigService _remoteConfig;
  final CupertinoUpdateDialogService _dialog;
  final CrashReportingManager _crashReporting;

  VersionChecker(this._remoteConfig, this._dialog, this._crashReporting);

  Future<UpdateStatus> fetchStatus() async {
    try {
      final remote = await _remoteConfig.fetchConfig();
      final package = await PackageInfo.fromPlatform();

      _crashReporting.setCrashReportingKeyWithEnumKey(
        CrashReportingKey.appVersion,
        '${Platform.isAndroid ? 'Android' : 'iOS'} ${package.version}',
      );

      final current = int.tryParse(package.buildNumber) ?? 0;
      final latest = int.tryParse(
            Platform.isAndroid ? remote.androidVersion : remote.iosVersion,
          ) ??
          0;
      if (current >= latest) return UpdateStatus.upToDate;

      final critical = Platform.isAndroid
          ? remote.isCriticalAndroid
          : remote.isCriticalIos;
      return critical ? UpdateStatus.critical : UpdateStatus.optional;
    } catch (e) {
      safePrint('Remote config failed: $e');
      return UpdateStatus.upToDate;
    }
  }

  Future<void> promptIfNeeded(BuildContext context, UpdateStatus status) {
    if (status == UpdateStatus.upToDate) return Future.value();

    final proceed = Completer<void>();
    _dialog.showUpdateDialog(
      context,
      isCritical: status == UpdateStatus.critical,
      onUpdate: _launchStore,
      onSkip: proceed.complete,
    );
    return proceed.future;
  }

  void _launchStore() {
    if (Platform.isIOS && AppStrings.iosAppStoreId.isEmpty) return;

    final url = Platform.isAndroid
        ? AppStrings.androidStoreUrl
        : AppStrings.iosStoreUrl;
    launchUrl(Uri.parse(url));
  }
}
