import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'crash_reporting_tool.dart';
import 'crash_reporting_tool_identifier.dart';

class CrashlyticsTool implements CrashReportingTool {
  @override
  final identifier = const CrashReportingToolIdentifier("Crashlytics");

  @override
  void log({
    int? priority,
    String? tag,
    required String message,
    Exception? exception,
    StackTrace? stackTrace,
  }) {
    FirebaseCrashlytics.instance.log("$tag: $message");
    if (exception != null) {
      FirebaseCrashlytics.instance.recordError(
        exception,
        stackTrace,
        reason: message,
      );
    }
  }

  @override
  void setCrashReportingKey(String key, dynamic value) {
    FirebaseCrashlytics.instance.setCustomKey(key, value.toString());
  }

  @override
  set identifier(CrashReportingToolIdentifier identifier) {}
}
