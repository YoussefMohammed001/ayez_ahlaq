abstract class IAnalyticsService {
  Future<void> logEvent(String name, [Map<String, Object>? parameters]);

  Future<void> logScreen(String screenName);

  Future<void> setUserId(String? id);

  Future<void> setUserProperty(String name, String? value);
}
