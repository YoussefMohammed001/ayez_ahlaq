import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../domain/entities/barber_notification.dart';

class BarberNotificationTapRouter {
  const BarberNotificationTapRouter();

  void handle(BuildContext context, BarberNotification notification) {
    switch (notification.referenceType ?? notification.type) {
      case 'booking':
        context.go(Routes.barberShell, extra: 1); // BarberShell tab 1 = bookings
        return;
      case 'homeService':
        final requestId = int.tryParse(notification.referenceId ?? '');
        if (requestId == null) return;
        context.push(Routes.barberHomeServiceRequestDetailScreen, extra: requestId);
        return;
      case 'homeServiceBroadcast':
        final requestId = int.tryParse(notification.referenceId ?? '');
        if (requestId == null) return;
        context.push(
          Routes.barberHomeServiceBroadcastRequestDetailScreen,
          extra: requestId,
        );
        return;
      case 'walletRequests':
        context.push(Routes.barberWalletRequestsScreen);
        return;
      case 'subscription':
        context.push(Routes.barberSubscriptionScreen);
        return;
      case 'subscriptionRequest':
        context.push(Routes.barberSubscriptionRequestsScreen);
        return;
      case 'account':
        context.push(Routes.barberDocumentsScreen);
        return;
      default:
        return;
    }
  }
}
