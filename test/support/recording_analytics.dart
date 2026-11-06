import 'package:ayez_ahlaq/core/analytics/i_analytics_service.dart';

class LoggedEvent {
  final String name;
  final Map<String, Object> parameters;

  const LoggedEvent(this.name, this.parameters);

  @override
  String toString() => '$name $parameters';
}

class RecordingAnalytics implements IAnalyticsService {
  final events = <LoggedEvent>[];

  List<String> get names => events.map((e) => e.name).toList();

  LoggedEvent? last(String name) =>
      events.where((e) => e.name == name).lastOrNull;

  @override
  Future<void> logEvent(String name, [Map<String, Object>? parameters]) async {
    events.add(LoggedEvent(name, parameters ?? const {}));
  }

  @override
  Future<void> logScreen(String screenName) async {}

  @override
  Future<void> setUserId(String? id) async {}

  @override
  Future<void> setUserProperty(String name, String? value) async {}
}
