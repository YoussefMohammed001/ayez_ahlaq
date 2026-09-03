import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/features/merchant/notifications/data/models/merchant_notification_model.dart';
import 'package:ayez_ahlaq/features/merchant/notifications/data/models/notification_page_model.dart';
import 'package:ayez_ahlaq/features/merchant/notifications/domain/entities/notification_kind.dart';

void main() {
  test('parses a notification page payload', () {
    final page = NotificationPageModel.fromJson({
      'content': [
        {
          'id': 10,
          'type': 'NEW_ORDER',
          'referenceType': 'ORDER',
          'referenceId': 55,
          'title': 'طلب جديد',
          'body': 'حلاق جديد بعت طلب',
          'seen': false,
          'createdAt': '2026-09-01T10:00:00',
        },
      ],
      'page': 0,
      'size': 20,
      'totalElements': 1,
      'totalPages': 1,
    });

    expect(page.content, hasLength(1));
    expect(page.page, 0);
    expect(page.hasMore, isFalse);

    final notification = page.content.first;
    expect(notification.id, 10);
    expect(notification.referenceId, '55');
    expect(notification.kind, NotificationKind.newOrder);
    expect(notification.seen, isFalse);
  });

  test('hasMore is true when more pages remain', () {
    final page = NotificationPageModel.fromJson({
      'content': const [],
      'page': 0,
      'size': 20,
      'totalElements': 45,
      'totalPages': 3,
    });

    expect(page.hasMore, isTrue);
  });

  test('derives notification kind from the type string', () {
    expect(
      MerchantNotificationModel.fromJson({
        'id': 1,
        'type': 'ORDER_CANCELLED',
        'title': '',
        'body': '',
        'createdAt': '2026-09-01T10:00:00',
      }).kind,
      NotificationKind.orderCancelled,
    );

    expect(
      MerchantNotificationModel.fromJson({
        'id': 2,
        'type': 'LOW_STOCK',
        'title': '',
        'body': '',
        'createdAt': '2026-09-01T10:00:00',
      }).kind,
      NotificationKind.lowStock,
    );

    expect(
      MerchantNotificationModel.fromJson({
        'id': 3,
        'type': 'SOMETHING_ELSE',
        'title': '',
        'body': '',
        'createdAt': '2026-09-01T10:00:00',
      }).kind,
      NotificationKind.general,
    );
  });
}
