import 'analytics_events.dart';
import 'analytics_params.dart';
import 'i_analytics_service.dart';

class AppAnalytics {
  final IAnalyticsService _analytics;

  AppAnalytics(this._analytics);

  Future<void> tourStarted(String source) => _analytics.logEvent(
    AnalyticsEvents.tourStarted,
    {AnalyticsParams.source: source},
  );

  Future<void> tourCompleted() =>
      _analytics.logEvent(AnalyticsEvents.tourCompleted);

  Future<void> tourSkipped() =>
      _analytics.logEvent(AnalyticsEvents.tourSkipped);

  Future<void> setupStepOpened(String step) => _analytics.logEvent(
    AnalyticsEvents.setupStepOpened,
    {AnalyticsParams.step: step},
  );

  Future<void> setupCompleted() =>
      _analytics.logEvent(AnalyticsEvents.setupCompleted);

  Future<void> helpOpened() => _analytics.logEvent(AnalyticsEvents.helpOpened);

  Future<void> helpQuestionOpened(int index) => _analytics.logEvent(
    AnalyticsEvents.helpQuestionOpened,
    {AnalyticsParams.questionIndex: index},
  );

  Future<void> helpTourRequested() =>
      _analytics.logEvent(AnalyticsEvents.helpTourRequested);

  Future<void> autoAttendanceToggled({
    required bool enabled,
    required String result,
  }) => _analytics.logEvent(AnalyticsEvents.autoAttendanceToggled, {
    AnalyticsParams.enabled: enabled.toString(),
    AnalyticsParams.result: result,
  });

  Future<void> languageChanged(String language) => _analytics.logEvent(
    AnalyticsEvents.languageChanged,
    {AnalyticsParams.language: language},
  );

  Future<void> themeChanged(String theme) => _analytics.logEvent(
    AnalyticsEvents.themeChanged,
    {AnalyticsParams.theme: theme},
  );

  Future<void> externalLinkOpened(String target) => _analytics.logEvent(
    AnalyticsEvents.externalLinkOpened,
    {AnalyticsParams.target: target},
  );

  Future<void> locationPicked(String source) => _analytics.logEvent(
    AnalyticsEvents.locationPicked,
    {AnalyticsParams.source: source},
  );

  Future<void> loggedOut(String userType) => _analytics.logEvent(
    AnalyticsEvents.logout,
    {AnalyticsParams.userType: userType},
  );
}
