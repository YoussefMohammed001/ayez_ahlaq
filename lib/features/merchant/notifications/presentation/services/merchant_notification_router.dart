import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/notifications/notification_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../shared/user_type.dart';

class MerchantNotificationRouter implements NotificationRouter {
  @override
  void route({
    required String type,
    String? typeId,
    required UserType role,
    required BuildContext context,
  }) {
    if (role != UserType.merchant) return;

    context.go(Routes.merchantNotificationsScreen);
  }
}
