import 'package:flutter/material.dart';
import '../../../../../core/notifications/notification_router.dart';
import '../../../../../shared/user_type.dart';
import '../../domain/entities/customer_notification.dart';
import 'customer_notification_tap_router.dart';

class CustomerNotificationRouter implements NotificationRouter {
  final CustomerNotificationTapRouter _tapRouter =
      const CustomerNotificationTapRouter();

  @override
  void route({
    required String type,
    String? typeId,
    String? referenceType,
    required UserType role,
    required BuildContext context,
  }) {
    if (role != UserType.customer) return;

    _tapRouter.handle(
      context,
      CustomerNotification(
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
