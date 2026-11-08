import '../../../../../core/analytics/analytics_events.dart';
import '../../../../../core/analytics/analytics_params.dart';
import '../../../../../core/analytics/pending_analytics_queue.dart';
import '../../../../../core/cache/preferences_storage/preferences_storage.dart';
import '../../domain/entities/auto_attendance_outcome.dart';
import '../../domain/entities/geofence_transition.dart';
import '../services/local_auto_attendance_notifier.dart';

class AutoAttendanceReporter {
  final LocalAutoAttendanceNotifier _notifier;
  final PreferencesStorage _preferences;
  final GeofenceTransition _transition;

  AutoAttendanceReporter(this._notifier, this._preferences, this._transition);

  Future<void> report(AutoAttendanceOutcome outcome) async {
    await _notifier.notify(outcome);

    if (!outcome.isUserFacing) return;

    await PendingAnalyticsQueue(
      _preferences,
    ).enqueue(AnalyticsEvents.autoAttendanceTriggered, {
      AnalyticsParams.transition: _transition.name,
      AnalyticsParams.outcome: outcome.name,
    });
  }
}
