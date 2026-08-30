import '../../../../../generated/l10n.dart';
import '../../domain/entities/merchant_notification.dart';
import '../../domain/entities/notification_kind.dart';

class NotificationsMock {
  static const bool enabled = true;

  static List<MerchantNotification> items() {
    final now = DateTime.now();

    return [
      MerchantNotification(
        id: 1,
        kind: NotificationKind.newOrder,
        title: S().notifNewOrderTitle,
        body: S().notifNewOrderBody,
        createdAt: now,
      ),
      MerchantNotification(
        id: 2,
        kind: NotificationKind.lowStock,
        title: S().notifLowStockTitle,
        body: S().notifLowStockBody,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      MerchantNotification(
        id: 3,
        kind: NotificationKind.orderCancelled,
        title: S().notifOrderCancelledTitle,
        body: S().notifOrderCancelledBody,
        createdAt: now.subtract(const Duration(days: 3)),
        seen: true,
      ),
      MerchantNotification(
        id: 4,
        kind: NotificationKind.discountEnded,
        title: S().notifDiscountEndedTitle,
        body: S().notifDiscountEndedBody,
        createdAt: now.subtract(const Duration(days: 9)),
        seen: true,
      ),
    ];
  }
}
