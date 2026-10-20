import 'package:ayez_ahlaq/core/app_startup/remote_config_service.dart';
import 'package:ayez_ahlaq/core/app_startup/update_dialog_service.dart';
import 'package:ayez_ahlaq/core/app_startup/update_status.dart';
import 'package:ayez_ahlaq/core/app_startup/version_checker.dart';
import 'package:ayez_ahlaq/core/crash_reporting/crash_reporting_keys.dart';
import 'package:ayez_ahlaq/core/crash_reporting/crash_reporting_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FakeRemoteConfig extends Fake implements IRemoteConfigService {
  final RemoteConfigValues? values;

  FakeRemoteConfig(this.values);

  @override
  Future<RemoteConfigValues> fetchConfig() async {
    final current = values;
    if (current == null) throw Exception('offline');
    return current;
  }
}

class FakeCrashReporting extends Fake implements CrashReportingManager {
  @override
  void setCrashReportingKeyWithEnumKey(
    CrashReportingKey key,
    dynamic value, {
    bool stored = false,
  }) {}
}

RemoteConfigValues remote(String version, {bool critical = false}) =>
    RemoteConfigValues(
      androidVersion: version,
      iosVersion: version,
      isCriticalAndroid: critical,
      isCriticalIos: critical,
    );

VersionChecker checker(RemoteConfigValues? values) => VersionChecker(
  FakeRemoteConfig(values),
  CupertinoUpdateDialogService(),
  FakeCrashReporting(),
);

void main() {
  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'app',
      packageName: 'com.example.app',
      version: '1.0.0',
      buildNumber: '10',
      buildSignature: '',
    );
  });

  test('same or newer build is up to date', () async {
    expect(await checker(remote('10')).fetchStatus(), UpdateStatus.upToDate);
    expect(await checker(remote('9')).fetchStatus(), UpdateStatus.upToDate);
  });

  test('a newer store build is an optional update', () async {
    expect(await checker(remote('11')).fetchStatus(), UpdateStatus.optional);
  });

  test('a newer store build flagged critical is mandatory', () async {
    expect(
      await checker(remote('11', critical: true)).fetchStatus(),
      UpdateStatus.critical,
    );
  });

  test('a failing remote config never blocks the app', () async {
    expect(await checker(null).fetchStatus(), UpdateStatus.upToDate);
  });
}
