import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/auto_attendance_outcome.dart';
import '../../domain/entities/geofence_transition.dart';
import '../../domain/repos/i_auto_attendance_notifier.dart';

class LocalAutoAttendanceNotifier implements IAutoAttendanceNotifier {
  static const _channelId = 'high_importance_channel';
  static const _resultId = 4107;
  static const _receivedId = 4108;
  static const _icon = '@drawable/ic_notification';

  final bool diagnostic;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _ready = false;

  LocalAutoAttendanceNotifier({this.diagnostic = false});

  @override
  Future<void> announceReceived(GeofenceTransition transition) async {
    if (!diagnostic) return;

    await _show(_receivedId, switch (transition) {
      GeofenceTransition.entered => S().autoAttendanceDiagEntered,
      GeofenceTransition.exited => S().autoAttendanceDiagExited,
    });
  }

  @override
  Future<void> notify(AutoAttendanceOutcome outcome) async {
    if (!outcome.isUserFacing && !diagnostic) return;

    await _show(_resultId, _bodyOf(outcome));
  }

  String _bodyOf(AutoAttendanceOutcome outcome) => switch (outcome) {
    AutoAttendanceOutcome.checkedIn => S().autoAttendanceCheckedInNotice,
    AutoAttendanceOutcome.checkedOut => S().autoAttendanceCheckedOutNotice,
    AutoAttendanceOutcome.failed => S().autoAttendanceFailedNotice,
    AutoAttendanceOutcome.alreadyOnShift =>
      S().autoAttendanceDiagAlreadyOnShift,
    AutoAttendanceOutcome.noOpenShift => S().autoAttendanceDiagNoOpenShift,
    AutoAttendanceOutcome.featureInactive =>
      S().autoAttendanceDiagFeatureInactive,
    AutoAttendanceOutcome.disabled => S().autoAttendanceDiagDisabled,
    AutoAttendanceOutcome.needsTracking => S().autoAttendanceDiagTracking,
  };

  Future<void> _show(int id, String body) async {
    if (!_ready) {
      await _plugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings(_icon),
          iOS: DarwinInitializationSettings(),
        ),
      );
      _ready = true;
    }

    await _plugin.show(
      id,
      S().attendanceTitle,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'High Importance Notifications',
          icon: _icon,
          color: Color(0xFFC6982F),
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(presentAlert: true, presentSound: true),
      ),
    );
  }
}
