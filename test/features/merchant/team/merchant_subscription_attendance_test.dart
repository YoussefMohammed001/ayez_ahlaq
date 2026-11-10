import 'package:ayez_ahlaq/features/merchant/subscription/data/models/subscription_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('reads attendanceEnabled and an unlimited member cap from dev', () {
    final subscription = SubscriptionModel.fromJson({
      'hasSubscription': true,
      'planId': 7,
      'planName': 'VIP',
      'fee': 1500,
      'status': 'PAUSED',
      'autoCharge': true,
      'attendanceEnabled': true,
      'employees': {'cap': null, 'used': 0, 'remaining': null},
    });

    expect(subscription.attendanceEnabled, isTrue);
    expect(subscription.employees?.cap, isNull);
    expect(subscription.employees?.used, 0);
  });

  test('defaults attendanceEnabled to false when the field is missing', () {
    final subscription = SubscriptionModel.fromJson({'hasSubscription': false});

    expect(subscription.attendanceEnabled, isFalse);
  });
}
