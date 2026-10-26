import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/notifications/notification_reference.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../domain/entities/merchant_notification.dart';

class MerchantNotificationTapRouter {
  const MerchantNotificationTapRouter();

  void handle(BuildContext context, MerchantNotification notification) {
    final referenceId = int.tryParse(notification.referenceId ?? '');

    switch (NotificationReference.canonical(
      type: notification.type,
      referenceType: notification.referenceType,
    )) {
      case 'order':
      case 'productOrder':
      case 'rating':
        context.go(Routes.merchantShell, extra: 2); // MerchantShell tab 2 = orders
        return;
      case 'lowStock':
        if (referenceId != null) {
          context.push(Routes.merchantProductDetailsScreen, extra: referenceId);
          return;
        }
        context.go(Routes.merchantShell, extra: 1); // MerchantShell tab 1 = products
        return;
      case 'discountEnded':
        context.push(Routes.merchantDiscountsScreen);
        return;
      case 'walletRequests':
        context.push(Routes.merchantWalletRequestsScreen);
        return;
      case 'subscription':
        context.push(Routes.merchantSubscriptionScreen);
        return;
      case 'subscriptionRequest':
        context.push(Routes.merchantSubscriptionRequestsScreen);
        return;
      case 'account':
        context.push(Routes.merchantDocumentsScreen);
        return;
      default:
        return;
    }
  }
}
