import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../domain/entities/merchant_notification.dart';

class MerchantNotificationTapRouter {
  const MerchantNotificationTapRouter();

  void handle(BuildContext context, MerchantNotification notification) {
    final referenceId = int.tryParse(notification.referenceId ?? '');

    switch (notification.referenceType ?? notification.type) {
      case 'order':
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
