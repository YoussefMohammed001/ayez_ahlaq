import 'package:sentry_flutter/sentry_flutter.dart';
import 'crash_reporting_tool.dart';
import 'crash_reporting_tool_identifier.dart';

class SentryTool implements CrashReportingTool {
  @override
  final identifier = const CrashReportingToolIdentifier("Sentry");

  @override
  void log({
    int? priority,
    String? tag,
    required String message,
    Exception? exception,
    StackTrace? stackTrace,
  }) {
    Sentry.captureMessage(
      "$tag: $message",
      level: priority == null ? SentryLevel.info : _mapPriority(priority),
    );

    if (exception != null) {
      Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }

  @override
  void setCrashReportingKey(String key, dynamic value) {
    Sentry.configureScope((scope) {
      scope.setTag(key, value.toString());
    });
  }

  SentryLevel _mapPriority(int priority) {
    switch (priority) {
      case 1:
        return SentryLevel.debug;
      case 2:
        return SentryLevel.info;
      case 3:
        return SentryLevel.warning;
      case 4:
        return SentryLevel.error;
      default:
        return SentryLevel.error;
    }
  }

  @override
  set identifier(CrashReportingToolIdentifier identifier) {}
}
