import 'package:in_app_review/in_app_review.dart';
import '../analytics/analytics_events.dart';
import '../analytics/i_analytics_service.dart';
import '../cache/preferences_storage/preferences_storage.dart';
import '../cache/preferences_storage/preferences_storage_keys.dart';
import '../helpers/safe_print.dart';

class ReviewPromptService {
  static const _minPositiveActions = 3;
  static const _maxPrompts = 3;
  static const _minDaysBetweenPrompts = 90;

  final PreferencesStorage _preferences;
  final IAnalyticsService _analytics;
  final InAppReview _inAppReview;

  ReviewPromptService(this._preferences, this._analytics)
    : _inAppReview = InAppReview.instance;

  Future<void> onPositiveAction() async {
    final actions =
        _preferences.getInt(key: PreferencesKeys.positiveActionCount) + 1;
    await _preferences.putInt(
      key: PreferencesKeys.positiveActionCount,
      value: actions,
    );

    if (actions < _minPositiveActions || !_isDue()) return;
    await _requestReview();
  }

  bool _isDue() {
    final prompts = _preferences.getInt(key: PreferencesKeys.reviewPromptCount);
    if (prompts >= _maxPrompts) return false;

    final lastMillis = _preferences.getInt(
      key: PreferencesKeys.lastReviewPromptAt,
    );
    if (lastMillis == 0) return true;

    final last = DateTime.fromMillisecondsSinceEpoch(lastMillis);
    return DateTime.now().difference(last).inDays >= _minDaysBetweenPrompts;
  }

  Future<void> _requestReview() async {
    try {
      if (!await _inAppReview.isAvailable()) return;

      await _recordPrompt();
      await _analytics.logEvent(AnalyticsEvents.reviewPromptShown);
      await _inAppReview.requestReview();
    } catch (error) {
      safePrint('review prompt failed: $error');
    }
  }

  Future<void> _recordPrompt() async {
    final prompts = _preferences.getInt(key: PreferencesKeys.reviewPromptCount);
    await _preferences.putInt(
      key: PreferencesKeys.reviewPromptCount,
      value: prompts + 1,
    );
    await _preferences.putInt(
      key: PreferencesKeys.lastReviewPromptAt,
      value: DateTime.now().millisecondsSinceEpoch,
    );
  }
}
