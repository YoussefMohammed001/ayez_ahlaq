import 'package:ayez_ahlaq/core/notifications/notification_reference.dart';
import 'package:ayez_ahlaq/core/notifications/notification_payload.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('canonical from the inbox referenceType', () {
    final cases = <String, String>{
      'booking': 'booking',
      'homeService': 'homeService',
      'homeServiceBroadcast': 'homeServiceBroadcast',
      'product_order': 'productOrder',
      'money_item_occurrence': 'moneyItemOccurrence',
      'moneyPin': 'moneyPin',
      'admin_announcement': 'adminAnnouncement',
      'walletRequests': 'walletRequests',
      'subscriptionRequest': 'subscriptionRequest',
      'order': 'order',
    };

    cases.forEach((referenceType, expected) {
      test('$referenceType -> $expected', () {
        expect(
          NotificationReference.canonical(type: 'x', referenceType: referenceType),
          expected,
        );
      });
    });
  });

  group('canonical from the push type alone', () {
    final cases = <String, String>{
      'attendance_check_in': 'attendance',
      'attendance_check_out': 'attendance',
      'booking_requested': 'booking',
      'booking_your_turn': 'booking',
      'home_service_broadcast_closed': 'homeServiceBroadcast',
      'home_service_price_confirmed': 'homeService',
      'order_status_changed': 'productOrder',
      'store_order_requested': 'productOrder',
      'order_accepted': 'productOrder',
      'subscription_request_approved': 'subscriptionRequest',
      'subscription_charged': 'subscription',
      'wallet_request_approved': 'walletRequests',
      'money_item_due': 'moneyItemOccurrence',
      'money_pin_reset': 'moneyPin',
      'account_activated': 'account',
      'admin_announcement': 'adminAnnouncement',
      'merchant_broadcast': 'merchant',
      'shop_broadcast': 'shop',
      'rating_received': 'rating',
    };

    cases.forEach((type, expected) {
      test('$type -> $expected', () {
        expect(NotificationReference.canonical(type: type), expected);
      });
    });
  });

  group('NotificationPayload', () {
    test('reads the reference fields and ignores the notification id', () {
      final payload = NotificationPayload.fromMap({
        'type': 'booking_requested',
        'id': '99',
        'referenceType': 'booking',
        'referenceId': 12,
      });

      expect(payload.type, 'booking_requested');
      expect(payload.referenceType, 'booking');
      expect(payload.typeId, '12');
    });

    test('accepts the legacy type_id key', () {
      final payload = NotificationPayload.fromMap({
        'type': 'booking',
        'type_id': '7',
      });

      expect(payload.typeId, '7');
      expect(payload.referenceType, isNull);
    });
  });

  group('every push shape resolves to the same screen key', () {
    final shapes = <String, Map<String, dynamic>>{
      'type + type_id': {'type': 'booking_requested', 'type_id': '5'},
      'type + typeId': {'type': 'booking_requested', 'typeId': 5},
      'type + referenceType + referenceId': {
        'type': 'booking_requested',
        'referenceType': 'booking',
        'referenceId': '5',
      },
      'type + snake reference keys': {
        'type': 'booking_requested',
        'reference_type': 'booking',
        'reference_id': '5',
      },
      'type only': {'type': 'booking_requested'},
      'reference type as the type': {'type': 'booking', 'type_id': '5'},
      'notificationType + notificationTypeId': {
        'notificationType': 'booking_requested',
        'notificationTypeId': '5',
      },
      'notification_type + notification_type_id': {
        'notification_type': 'booking_requested',
        'notification_type_id': 5,
      },
    };

    shapes.forEach((name, data) {
      test(name, () {
        final payload = NotificationPayload.fromMap(data);
        expect(
          NotificationReference.canonical(
            type: payload.type,
            referenceType: payload.referenceType,
          ),
          'booking',
        );
      });
    });

    test('empty and non-string values do not break parsing', () {
      final payload = NotificationPayload.fromMap({
        'type': 7,
        'type_id': '',
        'referenceType': '',
      });

      expect(payload.type, '7');
      expect(payload.typeId, isNull);
      expect(payload.referenceType, isNull);
    });

    test('an empty payload yields an empty type without throwing', () {
      final payload = NotificationPayload.fromMap({});

      expect(payload.type, '');
      expect(
        NotificationReference.canonical(type: payload.type),
        '',
      );
    });
  });
}
