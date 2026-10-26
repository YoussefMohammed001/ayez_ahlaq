import 'package:flutter/material.dart';
import '../../../../../core/notifications/notification_router.dart';
import '../../../../../shared/user_type.dart';
import '../../domain/entities/barber_notification.dart';
import 'barber_notification_tap_router.dart';

class BarberNotificationRouter implements NotificationRouter {
  final BarberNotificationTapRouter _tapRouter =
      const BarberNotificationTapRouter();

  @override
  void route({
    required String type,
    String? typeId,
    String? referenceType,
    required UserType role,
    required BuildContext context,
  }) {
    if (role != UserType.barber) return;

    _tapRouter.handle(
      context,
      BarberNotification(
        id: 0,
        type: type,
        referenceType: referenceType,
        referenceId: typeId,
        title: '',
        body: '',
        createdAt: DateTime.now(),
      ),
    );
  }
}
