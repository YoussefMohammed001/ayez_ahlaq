import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage_keys.dart';
import 'package:ayez_ahlaq/core/di/sl.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/features/merchant/notifications/domain/entities/merchant_notification.dart';
import 'package:ayez_ahlaq/features/merchant/notifications/presentation/services/merchant_notification_tap_router.dart';
import 'package:ayez_ahlaq/features/merchant/sub_merchant/domain/sub_merchant_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

MerchantNotification _notification(String type, {String? referenceId}) =>
    MerchantNotification(
      id: 1,
      type: type,
      referenceId: referenceId,
      title: 't',
      body: 'b',
      createdAt: DateTime(2026, 11, 11),
    );

Future<void> _accountKind(String kind) async {
  SharedPreferences.setMockInitialValues({
    PreferencesKeys.merchantAccountKind.name: kind,
  });
  await sl.reset();
  sl.registerSingleton(
    PreferencesStorage(await SharedPreferences.getInstance()),
  );
}

Future<List<String>> _tap(
  WidgetTester tester,
  MerchantNotification notification,
) async {
  final visited = <String>[];
  final router = GoRouter(
    initialLocation: '/start',
    routes: [
      GoRoute(
        path: '/start',
        builder: (context, _) => TextButton(
          onPressed: () => const MerchantNotificationTapRouter().handle(
            context,
            notification,
          ),
          child: const Text('tap'),
        ),
      ),
      for (final path in [
        Routes.merchantShell,
        Routes.subMerchantShell,
        Routes.merchantProductDetailsScreen,
        Routes.merchantDiscountsScreen,
        Routes.merchantWalletRequestsScreen,
        Routes.merchantSubscriptionScreen,
      ])
        GoRoute(
          path: path,
          builder: (_, state) {
            visited.add('$path:${state.extra}');
            return const SizedBox();
          },
        ),
    ],
  );
  await tester.pumpWidget(MaterialApp.router(routerConfig: router));
  await tester.tap(find.text('tap'));
  await tester.pumpAndSettle();
  return visited;
}

void main() {
  group('a sub-merchant', () {
    setUp(() => _accountKind('subMerchant'));

    testWidgets('lands on the orders tab of the sub shell', (tester) async {
      expect(await _tap(tester, _notification('order_new')), [
        '${Routes.subMerchantShell}:${SubMerchantTab.orders.index}',
      ]);
    });

    testWidgets('lands on the attendance tab for attendance news', (
      tester,
    ) async {
      expect(await _tap(tester, _notification('attendance_check_in')), [
        '${Routes.subMerchantShell}:${SubMerchantTab.attendance.index}',
      ]);
    });

    testWidgets('opens the product for a low stock alert', (tester) async {
      expect(
        await _tap(tester, _notification('low_stock', referenceId: '29')),
        ['${Routes.merchantProductDetailsScreen}:29'],
      );
    });

    testWidgets('never reaches the owner-only screens', (tester) async {
      for (final type in [
        'discount_ended',
        'wallet_request_approved',
        'subscription_renewed',
        'account_blocked',
      ]) {
        expect(await _tap(tester, _notification(type)), isEmpty, reason: type);
      }
    });
  });

  group('the owner', () {
    setUp(() => _accountKind('owner'));

    testWidgets('keeps the old tabs of the owner shell', (tester) async {
      expect(await _tap(tester, _notification('order_new')), [
        '${Routes.merchantShell}:2',
      ]);
      expect(await _tap(tester, _notification('low_stock')), [
        '${Routes.merchantShell}:1',
      ]);
    });

    testWidgets('still opens the discounts and subscription screens', (
      tester,
    ) async {
      expect(await _tap(tester, _notification('discount_ended')), [
        '${Routes.merchantDiscountsScreen}:null',
      ]);
      expect(await _tap(tester, _notification('subscription_renewed')), [
        '${Routes.merchantSubscriptionScreen}:null',
      ]);
    });
  });
}
