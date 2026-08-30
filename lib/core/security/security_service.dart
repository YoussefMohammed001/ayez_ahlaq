import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:ayez_ahlaq/core/helpers/safe_print.dart';
import 'security_result.dart';

class SecurityService {
  static Future<SecurityResult> checkAll() async {
    final rooted = await _checkRooted();
    final emulator = await _checkEmulator();
    final proxy = _checkProxy();

    final result = SecurityResult(
      isRooted: rooted,
      isEmulator: emulator,
      isProxySet: proxy,
    );

    safePrint('🔐 Security check: $result');
    return result;
  }

  static Future<bool> _checkRooted() async {
    try {
      if (Platform.isAndroid) {
        const suspiciousPaths = [
          '/system/app/Superuser.apk',
          '/sbin/su',
          '/system/bin/su',
          '/system/xbin/su',
          '/data/local/xbin/su',
          '/data/local/bin/su',
          '/system/sd/xbin/su',
          '/system/bin/failsafe/su',
          '/data/local/su',
          '/su/bin/su',
        ];

        for (final path in suspiciousPaths) {
          if (await File(path).exists()) {
            safePrint('🚨 Root detected at: $path');
            return true;
          }
        }
        return false;
      }

      if (Platform.isIOS) {
        const suspiciousPaths = [
          '/Applications/Cydia.app',
          '/Library/MobileSubstrate/MobileSubstrate.dylib',
          '/bin/bash',
          '/usr/sbin/sshd',
          '/etc/apt',
          '/private/var/lib/apt/',
          '/usr/bin/ssh',
        ];

        for (final path in suspiciousPaths) {
          if (await File(path).exists()) {
            safePrint('🚨 Jailbreak detected at: $path');
            return true;
          }
        }
        return false;
      }

      return false;
    } catch (e) {
      safePrint('Root check error: $e');
      return false;
    }
  }

  static Future<bool> _checkEmulator() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final info = await deviceInfo.androidInfo;
        return !info.isPhysicalDevice;
      } else if (Platform.isIOS) {
        final info = await deviceInfo.iosInfo;
        return !info.isPhysicalDevice;
      }
      return false;
    } catch (e) {
      safePrint('Emulator check error: $e');
      return false;
    }
  }

  static bool _checkProxy() {
    try {
      final httpProxy = Platform.environment['http_proxy'];
      final httpsProxy = Platform.environment['https_proxy'];
      final httpProxyUpper = Platform.environment['HTTP_PROXY'];
      final httpsProxyUpper = Platform.environment['HTTPS_PROXY'];

      return httpProxy != null ||
          httpsProxy != null ||
          httpProxyUpper != null ||
          httpsProxyUpper != null;
    } catch (e) {
      safePrint('Proxy check error: $e');
      return false;
    }
  }
}
