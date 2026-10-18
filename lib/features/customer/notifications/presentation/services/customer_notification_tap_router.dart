import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../domain/entities/customer_notification.dart';

class CustomerNotificationTapRouter {
  const CustomerNotificationTapRouter();

  void handle(BuildContext context, CustomerNotification notification) {
    final referenceId = int.tryParse(notification.referenceId ?? '');

    switch (notification.referenceType ?? notification.type) {
      case 'booking':
        if (referenceId != null) {
          context.push(Routes.customerBookingDetailScreen, extra: referenceId);
          return;
        }
        context.push(Routes.customerBookingsScreen);
        return;
      case 'homeService':
        if (referenceId != null) {
          context.push(
            Routes.customerHomeServiceRequestDetailScreen,
            extra: referenceId,
          );
          return;
        }
        context.push(Routes.customerHomeServiceRequestsScreen);
        return;
      case 'shop':
        if (referenceId != null) {
          context.push(Routes.customerShopDetailScreen, extra: referenceId);
          return;
        }
        context.push(Routes.customerBrowseShopsScreen);
        return;
      default:
        return;
    }
  }
}
