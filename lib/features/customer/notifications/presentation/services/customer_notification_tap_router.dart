import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/notifications/notification_reference.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../domain/entities/customer_notification.dart';

class CustomerNotificationTapRouter {
  const CustomerNotificationTapRouter();

  void handle(BuildContext context, CustomerNotification notification) {
    final referenceId = int.tryParse(notification.referenceId ?? '');

    switch (NotificationReference.canonical(
      type: notification.type,
      referenceType: notification.referenceType,
    )) {
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
      case 'productOrder':
        context.push(Routes.customerStoreOrdersScreen);
        return;
      case 'walletRequests':
        context.push(Routes.customerWalletRequestsScreen);
        return;
      default:
        return;
    }
  }
}
