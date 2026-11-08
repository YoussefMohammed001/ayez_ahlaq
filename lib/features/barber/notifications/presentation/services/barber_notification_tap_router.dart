import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/notifications/notification_reference.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/session/session_scope.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../domain/entities/barber_notification.dart';

class BarberNotificationTapRouter {
  static const int _bookingsTab = 1;
  static const int _supplierOrdersTab = 1;
  static const int _storefrontOrdersTab = 3;
  static const String _storeOrderRequestedType = 'store_order_requested';
  static const String _attendanceTypePrefix = 'attendance_';
  static const String _attendanceFeatureTypePrefix = 'attendance_feature';

  final bool Function() isOwner;

  const BarberNotificationTapRouter({this.isOwner = _isOwnerInSession});

  static bool _isOwnerInSession() =>
      SessionScope.cubit<BarberProfileCubit>().state.profile?.owner ?? false;

  void handle(BuildContext context, BarberNotification notification) {
    final requestId = int.tryParse(notification.referenceId ?? '');

    final reference = notification.type.startsWith(_attendanceTypePrefix)
        ? 'attendance'
        : NotificationReference.canonical(
            type: notification.type,
            referenceType: notification.referenceType,
          );

    switch (reference) {
      case 'attendance':
        final isFeature = notification.type.startsWith(
          _attendanceFeatureTypePrefix,
        );
        context.push(
          isOwner() && !isFeature
              ? Routes.barberAttendanceTeamScreen
              : Routes.barberAttendanceScreen,
        );
        return;
      case 'salary':
        context.push(
          isOwner()
              ? Routes.barberSalaryDeductionsScreen
              : Routes.barberMySalaryScreen,
        );
        return;
      case 'booking':
        context.go(Routes.barberShell, extra: _bookingsTab);
        return;
      case 'homeService':
        if (requestId == null) return;
        context.push(Routes.barberHomeServiceRequestDetailScreen, extra: requestId);
        return;
      case 'homeServiceBroadcast':
        if (requestId == null) return;
        context.push(
          Routes.barberHomeServiceBroadcastRequestDetailScreen,
          extra: requestId,
        );
        return;
      case 'productOrder':
        if (notification.type == _storeOrderRequestedType) {
          context.push(Routes.barberStorefrontHomeScreen, extra: _storefrontOrdersTab);
          return;
        }
        context.push(Routes.barberStoreMerchantsScreen, extra: _supplierOrdersTab);
        return;
      case 'order':
        context.push(Routes.barberStorefrontHomeScreen, extra: _storefrontOrdersTab);
        return;
      case 'rating':
        context.push(Routes.barberReviewsScreen);
        return;
      case 'merchant':
        context.push(Routes.barberStoreMerchantsScreen);
        return;
      case 'moneyItemOccurrence':
      case 'moneyPin':
        context.push(Routes.barberMoneyPinScreen);
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
