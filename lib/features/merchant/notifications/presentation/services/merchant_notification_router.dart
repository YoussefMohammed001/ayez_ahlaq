import 'package:flutter/material.dart';
import '../../../../../core/notifications/notification_router.dart';
import '../../../../../shared/user_type.dart';
import '../../domain/entities/merchant_notification.dart';
import 'merchant_notification_tap_router.dart';

class MerchantNotificationRouter implements NotificationRouter {
  final MerchantNotificationTapRouter _tapRouter =
      const MerchantNotificationTapRouter();

  @override
  void route({
    required String type,
    String? typeId,
    String? referenceType,
    required UserType role,
    required BuildContext context,
  }) {
    if (role != UserType.merchant) return;

    _tapRouter.handle(
      context,
      MerchantNotification(
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
