import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigValues {
  final String androidVersion;
  final String iosVersion;
  final bool isCriticalAndroid;
  final bool isCriticalIos;

  RemoteConfigValues({
    required this.androidVersion,
    required this.iosVersion,
    required this.isCriticalAndroid,
    required this.isCriticalIos,
  });
}

abstract class IRemoteConfigService {
  Future<RemoteConfigValues> fetchConfig();
}

class FirebaseRemoteConfigService implements IRemoteConfigService {
  @override
  Future<RemoteConfigValues> fetchConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 5),
        minimumFetchInterval: const Duration(seconds: 0),
      ),
    );
    await remoteConfig.fetchAndActivate();

    return RemoteConfigValues(
      androidVersion: remoteConfig.getString('android_app_version'),
      iosVersion: remoteConfig.getString('ios_app_version'),
      isCriticalAndroid: remoteConfig.getBool('critical_android'),
      isCriticalIos: remoteConfig.getBool('critical_ios'),
    );
  }
}
