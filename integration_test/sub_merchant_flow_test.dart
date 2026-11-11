import 'package:ayez_ahlaq/bootstrap.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/cache/secure_storage/app_flutter_secure_storage.dart';
import 'package:ayez_ahlaq/core/constants/strings.dart';
import 'package:ayez_ahlaq/core/di/sl.dart';
import 'package:ayez_ahlaq/core/helpers/user_helpers.dart';
import 'package:ayez_ahlaq/core/network/dio/network_service.dart';
import 'package:ayez_ahlaq/core/routes/app_routes.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/core/widgets/app_bottom_nav_bar.dart';
import 'package:ayez_ahlaq/core/widgets/primary_cta_button.dart';
import 'package:ayez_ahlaq/env/flavor.dart';
import 'package:ayez_ahlaq/features/merchant/sales/presentation/widgets/new_sale_form.dart';
import 'package:ayez_ahlaq/features/merchant/sales/presentation/widgets/sale_product_row.dart';
import 'package:ayez_ahlaq/firebase_options_dev.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:ayez_ahlaq/shared/user_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _ownerPhone = '01001234599';
const _ownerPassword = 'secret123';
const _memberPhone = '01077777701';
const _memberId = 4000014;
const _defaultPassword = '123456';
const _newPassword = 'Sub12345';
const _strict = bool.fromEnvironment('STRICT', defaultValue: true);

class _OwnerApi {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppStrings.devBaseUrl,
      validateStatus: (_) => true,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<void> login() async {
    final response = await _dio.post(
      'merchant/login',
      data: {'phoneNumber': _ownerPhone, 'password': _ownerPassword},
    );
    final token = response.data['data']['token'] as String;
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<void> setPermissions({required bool canSell}) async {
    await _dio.put(
      'merchant/member/$_memberId/permissions',
      data: {'canManageProducts': false, 'canSell': canSell},
    );
  }

  Future<void> resetMemberPassword() async {
    await _dio.put('merchant/member/$_memberId/resetPassword', data: {});
  }

  Future<void> cancelMemberSales() async {
    final response = await _dio.get(
      'merchant/sale',
      queryParameters: {'page': 0, 'size': 50},
    );
    final sales = response.data['data']['content'] as List;
    for (final sale in sales) {
      if (sale['soldByMemberId'] == _memberId && sale['status'] == 'DONE') {
        await _dio.put('merchant/sale/${sale['id']}/cancel', data: {});
      }
    }
  }

  Future<void> restoreSub() async {
    await setPermissions(canSell: false);
    await cancelMemberSales();
    await resetMemberPassword();
  }
}

Finder _navTab(String label) => find.descendant(
  of: find.byType(AppBottomNavBar),
  matching: find.text(label),
);

Future<void> _wait(WidgetTester tester, [int seconds = 2]) async {
  for (var i = 0; i < seconds * 4; i++) {
    await tester.pump(const Duration(milliseconds: 250));
  }
}

Future<void> _waitFor(
  WidgetTester tester,
  Finder finder,
  String what, {
  int seconds = 25,
}) async {
  for (var i = 0; i < seconds * 4; i++) {
    await tester.pump(const Duration(milliseconds: 250));
    if (finder.evaluate().isNotEmpty) return;
  }
  fail('Timed out waiting for: $what');
}

Future<void> _waitGone(
  WidgetTester tester,
  Finder finder,
  String what, {
  int seconds = 25,
}) async {
  for (var i = 0; i < seconds * 4; i++) {
    await tester.pump(const Duration(milliseconds: 250));
    if (finder.evaluate().isEmpty) return;
  }
  fail('Still visible after $seconds seconds: $what');
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final owner = _OwnerApi();

  tearDownAll(() async {
    await owner.login();
    await owner.restoreSub();
  });

  testWidgets('a sub-merchant from login to a sale', (tester) async {
    try {
      await owner.login();
      await owner.restoreSub();

      await appFlutterSecureStorage.deleteAll();
      await (await SharedPreferences.getInstance()).clear();
      await bootstrap(Flavor.dev, DefaultFirebaseOptions.currentPlatform);
      await _wait(tester, 3);
      await UserHelpers.setUserType(UserType.merchant);
      await binding.convertFlutterSurfaceToImage();

      routes.go(Routes.loginScreen);
      await _wait(tester, 2);

      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), _memberPhone);
      await tester.enterText(fields.at(1), _defaultPassword);
      await tester.tap(find.byType(PrimaryCtaButton).first);

      await _waitFor(
        tester,
        find.text(S().forceChangePasswordMessage),
        'the forced password change screen',
      );
      await binding.takeScreenshot('sub-01_force_change_password');

      final passwordFields = find.byType(TextField);
      await tester.enterText(passwordFields.at(0), _defaultPassword);
      await tester.enterText(passwordFields.at(1), _newPassword);
      await tester.enterText(passwordFields.at(2), _newPassword);
      await tester.tap(find.byType(PrimaryCtaButton).first);

      await _waitFor(
        tester,
        find.text(S().memberAttendanceDisabledTitle),
        'the attendance tab saying attendance is not enabled',
      );
      await binding.takeScreenshot('sub-02_attendance_disabled');
      await _wait(tester, 4);
      expect(find.text(S().tabOrders), findsWidgets);
      expect(find.text(S().tabProducts), findsWidgets);
      expect(find.text(S().tabAccount), findsWidgets);
      expect(find.text(S().salesTitle), findsNothing);

      await tester.tap(_navTab(S().tabOrders));
      await _wait(tester, 4);
      await binding.takeScreenshot('sub-03_orders');
      expect(find.text(S().barberOrders), findsWidgets);

      await tester.tap(_navTab(S().tabProducts));
      await _wait(tester, 4);
      await binding.takeScreenshot('sub-04_products_read_only');
      expect(find.byIcon(Icons.add), findsNothing);
      expect(find.byIcon(Icons.delete_outline), findsNothing);

      await tester.tap(_navTab(S().tabAccount));
      await _wait(tester, 4);
      await binding.takeScreenshot('sub-05_account');
      expect(find.text(S().changePassword), findsWidgets);
      expect(find.text(S().shopSection), findsWidgets);

      await owner.setPermissions(canSell: true);
      binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await _waitFor(
        tester,
        find.text(S().salesTitle),
        'the sales tab after the owner granted canSell and the app resumed',
      );
      await binding.takeScreenshot('sub-06_sales_tab_appeared');

      await tester.tap(_navTab(S().salesTitle));
      await _waitFor(
        tester,
        find.text(S().newSaleTitle),
        'the sales tab with its new sale button',
      );
      await _wait(tester, 3);
      await binding.takeScreenshot('sub-07_sales_tab');
      expect(find.text(S().saleStatusDone), findsNothing);

      await tester.tap(find.text(S().newSaleTitle));
      await _waitFor(
        tester,
        find.text(S().saleProductsTitle),
        'the new sale screen with products',
      );
      final stepperAdd = find.descendant(
        of: find.byType(SaleProductRow),
        matching: find.byIcon(Icons.add_rounded),
      );
      await _waitFor(
        tester,
        stepperAdd,
        'a product row with a quantity stepper',
      );
      await binding.takeScreenshot('sub-08_new_sale_empty');

      await tester.tap(stepperAdd.first);
      await tester.pump(const Duration(milliseconds: 500));
      await tester.scrollUntilVisible(
        find.text(S().saleSubmit),
        300,
        scrollable: find
            .descendant(
              of: find.byType(NewSaleForm),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.pump(const Duration(milliseconds: 500));
      await _wait(tester, 7);
      await binding.takeScreenshot('sub-09_new_sale_with_item');
      await tester.tap(find.text(S().saleSubmit));

      await _waitFor(
        tester,
        find.text(S().saleStatusDone),
        'the recorded sale in the list',
      );
      await binding.takeScreenshot('sub-10_sale_recorded');
      await _wait(tester, 4);

      await tester.tap(find.text(S().saleStatusDone).first);
      await _waitFor(
        tester,
        find.text(S().saleDetailsTitle),
        'the sale details',
      );
      await binding.takeScreenshot('sub-11_sale_details');
      expect(find.text(S().cancelSaleTitle), findsNothing);

      await tester.tap(find.byIcon(Icons.arrow_back_ios).last);
      await _wait(tester, 2);

      await owner.setPermissions(canSell: false);
      final refused = await sl<NetworkService>().getData(
        endPoint: 'merchant/sale',
      );
      expect(refused.isLeft(), isTrue);

      await _waitGone(
        tester,
        find.text(S().salesTitle),
        'the sales tab after a 403 (should reload the permissions)',
      );
      await _wait(tester, 2);
      expect(find.byIcon(Icons.point_of_sale_rounded), findsNothing);
      await binding.takeScreenshot('sub-12_sales_tab_gone_after_403');
      expect(sl<PreferencesStorage>(), isNotNull);
    } catch (error, stack) {
      debugPrint('FLOW_ERROR: $error');
      debugPrint('FLOW_STACK: $stack');
      await binding.takeScreenshot('sub-ZZ_failure');
      if (_strict) rethrow;
    }
  });
}
