import 'package:ayez_ahlaq/core/security/security_service.dart';

class SecurityGuard {
  static Future<
    ({
      bool passed,
      String enReason,
      String arReason,
      String enFooter,
      String arFooter,
    })
  >
  verify() async {
    final result = await SecurityService.checkAll();

    if (result.isRooted) {
      return (
        passed: false,
        enReason:
            'This app cannot run on rooted or jailbroken devices.\n\nPlease use a standard device.',
        arReason:
            'لا يمكن تشغيل التطبيق على الأجهزة التي تم عمل روت أو جيلبريك لها.\n\nيرجى استخدام جهاز عادي.',
        enFooter: 'Please use a secure device to continue',
        arFooter: 'يرجى استخدام جهاز آمن للمتابعة',
      );
    }

    if (result.isEmulator) {
      return (
        passed: false,
        enReason:
            'This app cannot run on emulators or simulators.\n\nPlease use a physical device.',
        arReason:
            'لا يمكن تشغيل التطبيق على المحاكيات الافتراضية.\n\nيرجى استخدام جهاز حقيقي.',
        enFooter: 'Please use a secure device to continue',
        arFooter: 'يرجى استخدام جهاز آمن للمتابعة',
      );
    }

    if (result.isProxySet) {
      return (
        passed: false,
        enReason:
            'A network proxy has been detected.\n\nPlease disable it and try again.',
        arReason:
            'تم اكتشاف بروكسي على الشبكة.\n\nيرجى إيقافه والمحاولة مرة أخرى.',
        enFooter: 'Please use a secure device to continue',
        arFooter: 'يرجى استخدام جهاز آمن للمتابعة',
      );
    }

    return (
      passed: true,
      enReason: '',
      arReason: '',
      enFooter: '',
      arFooter: '',
    );
  }
}
