import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/analytics/api_action_mapper.dart';
import 'write_endpoints.dart';

final _validEventName = RegExp(r'^[A-Za-z][A-Za-z0-9_]{0,39}$');
const _reservedPrefixes = ['firebase_', 'google_', 'ga_'];

bool _ignored(String verb, String path) =>
    ApiActionMapper.isIgnored(verb, path);

void main() {
  group('every write endpoint of the app', () {
    test('is either named, or deliberately ignored, never generic', () {
      final generic = <String>[];

      for (final (verb, path) in writeEndpoints) {
        if (_ignored(verb, path)) continue;
        final action = ApiActionMapper.map(verb, path);
        if (action.eventName == 'app_action') generic.add('$verb $path');
      }

      expect(generic, isEmpty);
    });

    test('is ignored only on purpose', () {
      final ignored = [
        for (final (verb, path) in writeEndpoints)
          if (_ignored(verb, path)) '$verb $path',
      ];

      expect(ignored.every(_isKnownNoise), isTrue, reason: ignored.join('\n'));
    });
  });

  group('event names', () {
    test('are valid for Google Analytics', () {
      final names = ApiActionMapper.rules.map((r) => r.event).toSet();

      for (final name in names) {
        expect(_validEventName.hasMatch(name), isTrue, reason: name);
        expect(_reservedPrefixes.any(name.startsWith), isFalse, reason: name);
      }
    });

    test('stay well below the 500 event limit', () {
      final names = ApiActionMapper.rules.map((r) => r.event).toSet();

      expect(names.length, lessThan(200));
    });
  });

  group('mapping', () {
    test('keeps the names the dashboards already rely on', () {
      const expected = {
        ('POST', 'barber/login'): 'login',
        ('POST', 'customer/register'): 'sign_up',
        ('POST', 'customer/register/verifyOtp'): 'otp_verified',
        ('POST', 'customer/booking'): 'booking_created',
        ('PUT', 'customer/booking/9/cancel'): 'booking_cancelled',
        ('POST', 'customer/rating'): 'booking_rated',
        ('POST', 'customer/homeService'): 'home_service_requested',
        ('POST', 'barber/cart/checkout'): 'store_order_placed',
        ('POST', 'customer/favorite/4'): 'favorite_added',
        ('DELETE', 'customer/favorite/4'): 'favorite_removed',
        ('PUT', 'barber/booking/3/confirm'): 'barber_booking_accepted',
        ('PUT', 'barber/booking/3/reject'): 'barber_booking_rejected',
        ('PUT', 'barber/booking/3/status'): 'barber_booking_completed',
        ('POST', 'barber/service'): 'barber_service_added',
        ('PUT', 'barber/location'): 'barber_location_saved',
        ('POST', 'merchant/product'): 'merchant_product_added',
        ('PUT', 'merchant/order/2/ship'): 'merchant_order_updated',
      };

      for (final entry in expected.entries) {
        final (verb, path) = entry.key;
        expect(
          ApiActionMapper.map(verb, path).eventName,
          entry.value,
          reason: '$verb $path',
        );
      }
    });

    test('names the new attendance actions', () {
      expect(
        ApiActionMapper.map('POST', 'barber/attendance/checkIn').eventName,
        'barber_check_in',
      );
      expect(
        ApiActionMapper.map('POST', 'barber/attendance/checkOut').eventName,
        'barber_check_out',
      );
      expect(
        ApiActionMapper.map(
          'POST',
          'barber/attendanceFeature/request',
        ).eventName,
        'attendance_feature_requested',
      );
    });

    test('adds the role of the caller', () {
      expect(
        ApiActionMapper.map('PUT', 'merchant/location').parameters['user_type'],
        'merchant',
      );
      expect(
        ApiActionMapper.map(
          'POST',
          'customer/walletRequests',
        ).parameters['user_type'],
        'customer',
      );
    });

    test('ignores a leading slash, the api prefix and the query string', () {
      expect(
        ApiActionMapper.map(
          'POST',
          '/api/barber/attendance/checkIn?x=1',
        ).eventName,
        'barber_check_in',
      );
    });

    test(
      'still records anything it does not know, under one generic event',
      () {
        final action = ApiActionMapper.map('POST', 'barber/brand/new/thing');

        expect(action.eventName, 'app_action');
        expect(action.parameters['action'], 'post_barber_brand_new_thing');
      },
    );
  });
}

bool _isKnownNoise(String line) =>
    line.contains('deviceToken') ||
    line.contains('/seen') ||
    line.contains('quote') ||
    line.contains('moneyPin/verify');
