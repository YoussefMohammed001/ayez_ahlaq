import 'crash_reporting_keys.dart';
import 'crash_reporting_tool_identifier.dart';
import 'crash_reporting_tool.dart';

abstract class CrashReportingManager {
  Map<CrashReportingToolIdentifier, CrashReportingTool> get crashReportingTools;
  Map<String, dynamic> get crashReportingKeys;

  void log({
    int? priority,
    String? tag,
    required String message,
    Exception? exception,
    StackTrace? stackTrace,
  });

  void registerCrashReportingTool(CrashReportingTool crashReportingTool);

  void unRegisterCrashReportingTool(CrashReportingToolIdentifier identifier);

  CrashReportingTool? getCrashReportingTool(
    CrashReportingToolIdentifier identifier,
  );

  Future<void> initCrashReportingKeys();

  void setCrashReportingKey(String key, dynamic value, {bool stored = false});

  void setCrashReportingKeyWithEnumKey(
    CrashReportingKey key,
    dynamic value, {
    bool stored = false,
  });
}
