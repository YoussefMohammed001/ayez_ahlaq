import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/auto_attendance_outcome.dart';
import '../../domain/repos/i_auto_attendance_notifier.dart';

class LocalAutoAttendanceNotifier implements IAutoAttendanceNotifier {
  static const _channelId = 'high_importance_channel';
  static const _notificationId = 4107;
  static const _icon = '@drawable/ic_notification';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> notify(AutoAttendanceOutcome outcome) async {
    final body = switch (outcome) {
      AutoAttendanceOutcome.checkedIn => S().autoAttendanceCheckedInNotice,
      AutoAttendanceOutcome.checkedOut => S().autoAttendanceCheckedOutNotice,
      AutoAttendanceOutcome.failed => S().autoAttendanceFailedNotice,
      AutoAttendanceOutcome.ignored => null,
    };
    if (body == null) return;

    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings(_icon),
        iOS: DarwinInitializationSettings(),
      ),
    );

    await _plugin.show(
      _notificationId,
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
