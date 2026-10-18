import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import '../../env/flavor.dart';
import '../constants/strings.dart';
import '../helpers/safe_print.dart';
import 'remote_config_service.dart';

class ApiBaseUrlResolver {
  static const _fetchTimeout = Duration(seconds: 3);

  final IRemoteConfigService _remoteConfig;

  ApiBaseUrlResolver(this._remoteConfig);

  Future<String> resolve(Flavor flavor) async {
    if (flavor == Flavor.dev) return AppStrings.devBaseUrl;

    try {
      final values = await _latestValues();
      final reviewBuild = Platform.isIOS
          ? values.reviewDevApiBuildIos
          : values.reviewDevApiBuildAndroid;

      if (reviewBuild > 0 && reviewBuild == await _currentBuildNumber()) {
        return AppStrings.devBaseUrl;
      }
    } catch (error) {
      safePrint('base url resolve failed: $error');
    }
    return AppStrings.prodBaseUrl;
  }

  Future<RemoteConfigValues> _latestValues() async {
    try {
      return await _remoteConfig.fetchConfig().timeout(_fetchTimeout);
    } catch (_) {
      return _remoteConfig.cachedConfig();
    }
  }

  Future<int> _currentBuildNumber() async {
    final info = await PackageInfo.fromPlatform();
    return int.tryParse(info.buildNumber) ?? 0;
  }
}
