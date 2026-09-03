import 'package:flutter/material.dart';
import 'package:ayez_ahlaq/shared/user_type.dart';
import 'notification_router.dart';
import '../di/services_locator.dart';
import '../../features/merchant/notifications/presentation/services/merchant_notification_router.dart';
import '../../features/barber/notifications/presentation/services/barber_notification_router.dart';

class UserTypeNotificationRouter implements NotificationRouter {
  @override
  void route({
    required String type,
    String? typeId,
    required UserType role,
    required BuildContext context,
  }) {
    switch (role) {
      case UserType.merchant:
        sl<MerchantNotificationRouter>().route(
          type: type,
          typeId: typeId,
          role: role,
          context: context,
        );
        break;
      case UserType.barber:
        sl<BarberNotificationRouter>().route(
          type: type,
          typeId: typeId,
          role: role,
          context: context,
        );
        break;
      case UserType.customer:
        break;
    }
  }
}
