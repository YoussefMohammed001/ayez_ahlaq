import 'crash_reporting_tool_identifier.dart';

abstract class CrashReportingTool {
  late CrashReportingToolIdentifier identifier;

  void log({
    int? priority,
    String? tag,
    required String message,
    Exception? exception,
    StackTrace? stackTrace,
  });

  void setCrashReportingKey(String key, dynamic value);
}
