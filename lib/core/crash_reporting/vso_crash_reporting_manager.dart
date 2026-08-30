import '../cache/secure_storage/secure_storage.dart' show SecureStorage;
import 'crash_reporting_keys.dart';
import 'crash_reporting_manager.dart';
import 'crash_reporting_tool_identifier.dart';
import 'crash_reporting_tool.dart';

class VSOCrashReportingManager implements CrashReportingManager {
  final SecureStorage _storageManager;

  VSOCrashReportingManager(this._storageManager);

  @override
  Map<CrashReportingToolIdentifier, CrashReportingTool> crashReportingTools =
      {};

  @override
  Map<String, dynamic> crashReportingKeys = {};

  @override
  void log({
    int? priority,
    String? tag,
    required String message,
    Exception? exception,
    StackTrace? stackTrace,
  }) {
    for (var tool in crashReportingTools.values) {
      tool.log(
        message: message,
        tag: tag,
        priority: priority,
        exception: exception,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void registerCrashReportingTool(CrashReportingTool crashReportingTool) {
    crashReportingTools[crashReportingTool.identifier] = crashReportingTool;
  }

  @override
  void unRegisterCrashReportingTool(CrashReportingToolIdentifier identifier) {
    crashReportingTools.remove(identifier);
  }

  @override
  CrashReportingTool? getCrashReportingTool(
    CrashReportingToolIdentifier identifier,
  ) {
    return crashReportingTools[identifier];
  }

  @override
  Future<void> initCrashReportingKeys() async {
    final allKeys = await _storageManager.getAll();
    allKeys.forEach((k, v) {
      if (k.startsWith(CRASH_REPORT_KEY)) {
        String key = k.substring(CRASH_REPORT_KEY.length);
        setCrashReportingKey(key, v.toString(), stored: false);
      }
    });
  }

  @override
  void setCrashReportingKey(String key, dynamic value, {bool stored = false}) {
    crashReportingKeys[key] = value;

    for (var tool in crashReportingTools.values) {
      tool.setCrashReportingKey(key, value);
    }

    if (stored) {
      _storageManager.writeRaw("$CRASH_REPORT_KEY$key", value.toString());
    }
  }

  @override
  void setCrashReportingKeyWithEnumKey(
    CrashReportingKey key,
    dynamic value, {
    bool stored = false,
  }) {
    setCrashReportingKey(key.key, value, stored: stored);
  }

  static const String CRASH_REPORT_KEY = 'CRK_';
}
