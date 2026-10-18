import 'package:firebase_analytics/firebase_analytics.dart';
import '../helpers/safe_print.dart';
import 'i_analytics_service.dart';

class FirebaseAnalyticsService implements IAnalyticsService {
  FirebaseAnalytics get _analytics => FirebaseAnalytics.instance;

  @override
  Future<void> logEvent(String name, [Map<String, Object>? parameters]) {
    return _guard(
      () => _analytics.logEvent(name: name, parameters: parameters),
    );
  }

  @override
  Future<void> logScreen(String screenName) {
    return _guard(() => _analytics.logScreenView(screenName: screenName));
  }

  @override
  Future<void> setUserId(String? id) =>
      _guard(() => _analytics.setUserId(id: id));

  @override
  Future<void> setUserProperty(String name, String? value) {
    return _guard(() => _analytics.setUserProperty(name: name, value: value));
  }

  Future<void> _guard(Future<void> Function() action) async {
    try {
      await action();
    } catch (error) {
      safePrint('analytics failed: $error');
    }
  }
}
