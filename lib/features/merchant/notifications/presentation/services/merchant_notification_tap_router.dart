import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/notifications/notification_reference.dart';
import '../../../../../core/helpers/user_helpers.dart';
import '../../../../../core/routes/merchant_home_route.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../sub_merchant/domain/sub_merchant_tab.dart';
import '../../domain/entities/merchant_notification.dart';

class MerchantNotificationTapRouter {
  const MerchantNotificationTapRouter();

  bool get _isSubMerchant => UserHelpers.merchantAccountKind.isSubMerchant;

  void handle(BuildContext context, MerchantNotification notification) {
    final referenceId = int.tryParse(notification.referenceId ?? '');

    switch (NotificationReference.canonical(
      type: notification.type,
      referenceType: notification.referenceType,
    )) {
      case 'order':
      case 'productOrder':
      case 'rating':
        context.go(
          merchantHomeRoute,
          extra: _isSubMerchant ? SubMerchantTab.orders.index : 2,
        );
        return;
      case 'lowStock':
        if (referenceId != null) {
          context.push(Routes.merchantProductDetailsScreen, extra: referenceId);
          return;
        }
        context.go(
          merchantHomeRoute,
          extra: _isSubMerchant ? SubMerchantTab.products.index : 1,
        );
        return;
      case 'attendance':
        if (_isSubMerchant) {
          context.go(merchantHomeRoute, extra: SubMerchantTab.attendance.index);
        }
        return;
      case 'discountEnded':
        if (_isSubMerchant) return;
        context.push(Routes.merchantDiscountsScreen);
        return;
      case 'walletRequests':
        if (_isSubMerchant) return;
        context.push(Routes.merchantWalletRequestsScreen);
        return;
      case 'subscription':
        if (_isSubMerchant) return;
        context.push(Routes.merchantSubscriptionScreen);
        return;
      case 'subscriptionRequest':
        if (_isSubMerchant) return;
        context.push(Routes.merchantSubscriptionRequestsScreen);
        return;
      case 'account':
        if (_isSubMerchant) return;
        context.push(Routes.merchantDocumentsScreen);
        return;
      default:
        return;
    }
  }
}
