import 'package:ayez_ahlaq/bootstrap.dart';
import 'package:ayez_ahlaq/core/cache/secure_storage/app_flutter_secure_storage.dart';
import 'package:ayez_ahlaq/core/constants/strings.dart';
import 'package:ayez_ahlaq/core/helpers/user_helpers.dart';
import 'package:ayez_ahlaq/core/routes/app_routes.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/core/widgets/app_bottom_nav_bar.dart';
import 'package:ayez_ahlaq/core/widgets/primary_cta_button.dart';
import 'package:ayez_ahlaq/core/widgets/toggle_switch.dart';
import 'package:ayez_ahlaq/env/flavor.dart';
import 'package:ayez_ahlaq/features/merchant/sales/presentation/widgets/new_sale_form.dart';
import 'package:ayez_ahlaq/features/merchant/sales/presentation/widgets/sale_product_row.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/pages/merchant_member_detail_screen.dart';
import 'package:ayez_ahlaq/firebase_options_dev.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:ayez_ahlaq/shared/payment_methods/payment_method_tile.dart';
import 'package:ayez_ahlaq/shared/user_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _ownerPhone = '01001234599';
const _ownerPassword = 'secret123';
const _newMemberName = 'Device Test';
const _newMemberPhone = '01077777703';
const _newMemberPassword = 'Dev12345';
const _strict = bool.fromEnvironment('STRICT', defaultValue: true);

class _Api {
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
    _dio.options.headers['Authorization'] =
        'Bearer ${response.data['data']['token']}';
  }

  Future<Map<String, dynamic>?> findMember(String phone) async {
    final response = await _dio.get(
      'merchant/member',
      queryParameters: {'page': 0, 'size': 50},
    );
    final members = response.data['data']['content'] as List;
    for (final member in members) {
      if (member['phoneNumber'] == phone) return member as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> deleteMemberIfThere(String phone) async {
    final member = await findMember(phone);
    if (member != null) await _dio.delete('merchant/member/${member['id']}');
  }

  Future<List<dynamic>> sales() async {
    final response = await _dio.get(
      'merchant/sale',
      queryParameters: {'page': 0, 'size': 50},
    );
    return response.data['data']['content'] as List;
  }

  Future<void> cancelOwnerSales() async {
    for (final sale in await sales()) {
      if (sale['status'] == 'DONE') {
        await _dio.put('merchant/sale/${sale['id']}/cancel', data: {});
      }
    }
  }

  Future<void> clean() async {
    await deleteMemberIfThere(_newMemberPhone);
    await cancelOwnerSales();
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
  int seconds = 30,
}) async {
  for (var i = 0; i < seconds * 4; i++) {
    await tester.pump(const Duration(milliseconds: 250));
    if (finder.evaluate().isNotEmpty) return;
    if (i % 8 == 7) {
      final retry = find.text(S().tryAgain);
      if (retry.evaluate().isNotEmpty) await tester.tap(retry.first);
    }
  }
  fail('Timed out waiting for: $what');
}

Future<void> _waitGone(
  WidgetTester tester,
  Finder finder,
  String what, {
  int seconds = 30,
}) async {
  for (var i = 0; i < seconds * 4; i++) {
    await tester.pump(const Duration(milliseconds: 250));
    if (finder.evaluate().isEmpty) return;
  }
  fail('Still visible after $seconds seconds: $what');
}

Future<void> _scrollTo(WidgetTester tester, Finder target, Type screen) async {
  await tester.scrollUntilVisible(
    target,
    300,
    scrollable: find
        .descendant(of: find.byType(screen), matching: find.byType(Scrollable))
        .first,
  );
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final api = _Api();

  tearDownAll(() async {
    await api.login();
    await api.clean();
  });

  testWidgets('a merchant owner: team, a new member, sales and cancelling', (
    tester,
  ) async {
    try {
      await api.login();
      await api.clean();

      await appFlutterSecureStorage.deleteAll();
      await (await SharedPreferences.getInstance()).clear();
      await bootstrap(Flavor.dev, DefaultFirebaseOptions.currentPlatform);
      await _wait(tester, 3);
      await UserHelpers.setUserType(UserType.merchant);
      await binding.convertFlutterSurfaceToImage();

      routes.go(Routes.loginScreen);
      await _wait(tester, 2);
      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), _ownerPhone);
      await tester.enterText(fields.at(1), _ownerPassword);
      await tester.tap(find.byType(PrimaryCtaButton).first);

      await _waitFor(tester, _navTab(S().tabAccount), 'the owner shell');
      await _wait(tester, 6);
      await binding.takeScreenshot('owner-01_shell');

      await tester.tap(_navTab(S().tabAccount));
      await _waitFor(tester, find.text(S().teamTitle), 'the team row');
      await _wait(tester, 7);
      await binding.takeScreenshot('owner-02_account_menu');

      await tester.tap(find.text(S().teamTitle));
      await _waitFor(tester, find.text(S().quotaEmployees), 'the quota banner');
      await _waitFor(
        tester,
        find.text('Sub Test'),
        'the existing sub-merchant in the team list',
      );
      expect(find.text(S().ownerAttendanceLocked), findsOneWidget);
      await _wait(tester, 7);
      await binding.takeScreenshot('owner-03_team');

      await tester.tap(find.byIcon(Icons.person_add_alt_1_rounded));
      await _waitFor(tester, find.text(S().addMemberTitle), 'the add sheet');
      final sheetFields = find.byType(TextFormField);
      await tester.enterText(sheetFields.at(0), _newMemberName);
      await tester.enterText(sheetFields.at(1), _newMemberPhone);
      await tester.enterText(sheetFields.at(2), _newMemberPassword);
      await tester.enterText(sheetFields.at(3), '3000');
      await binding.takeScreenshot('owner-04_add_sheet');
      await _wait(tester, 7);
      await tester.ensureVisible(find.byType(PrimaryCtaButton).last);
      await tester.pump(const Duration(milliseconds: 500));
      await tester.tap(find.byType(PrimaryCtaButton).last);

      await _waitFor(tester, find.text(_newMemberName), 'the new member');
      final created = await api.findMember(_newMemberPhone);
      expect(created, isNotNull);
      expect(created!['salary'], 3000);
      expect(created['mustChangePassword'], false);
      await _wait(tester, 4);
      await binding.takeScreenshot('owner-05_member_added');

      await tester.tap(find.text(_newMemberName));
      await _waitFor(
        tester,
        find.text(S().memberPermissionsTitle),
        'the member details',
      );
      await _wait(tester, 4);
      await binding.takeScreenshot('owner-06_member_details');

      await tester.tap(find.byType(ToggleSwitch).at(1));
      await _wait(tester, 4);
      final afterToggle = await api.findMember(_newMemberPhone);
      expect(afterToggle!['canSell'], true);
      expect(afterToggle['canManageProducts'], false);
      await binding.takeScreenshot('owner-07_permission_on');

      await _scrollTo(
        tester,
        find.text(S().deleteMemberTitle),
        MerchantMemberDetailScreen,
      );
      await _wait(tester, 7);
      await tester.tap(find.text(S().deleteMemberTitle));
      await _waitFor(
        tester,
        find.text(S().deleteMemberConfirm),
        'the delete confirmation',
      );
      await binding.takeScreenshot('owner-08_delete_confirm');
      await tester.tap(find.text(S().deleteMemberTitle).last);

      await _waitFor(
        tester,
        find.text(S().quotaEmployees),
        'back on the team list after the delete',
      );
      await _waitGone(
        tester,
        find.text(_newMemberName),
        'the deleted member in the list',
      );
      expect(await api.findMember(_newMemberPhone), isNull);
      await _wait(tester, 4);
      await binding.takeScreenshot('owner-09_member_deleted');

      await tester.tap(find.byIcon(Icons.arrow_back_ios).last);
      await _waitFor(tester, find.text(S().salesTitle), 'the sales row');
      await _wait(tester, 7);
      await tester.tap(find.text(S().salesTitle));
      await _waitFor(
        tester,
        find.text(S().newSaleTitle),
        'the sales screen with its new sale button',
      );
      await _wait(tester, 4);
      await binding.takeScreenshot('owner-10_sales');

      await tester.tap(find.text(S().newSaleTitle));
      final stepperAdd = find.descendant(
        of: find.byType(SaleProductRow),
        matching: find.byIcon(Icons.add_rounded),
      );
      await _waitFor(tester, stepperAdd, 'a product row to sell');
      await tester.tap(stepperAdd.first);
      await tester.pump(const Duration(milliseconds: 500));
      await _waitFor(
        tester,
        find.byType(PaymentMethodTile),
        'the payment methods',
        seconds: 40,
      );
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
      await _wait(tester, 7);
      await tester.tap(find.text(S().saleSubmit));
      await _waitFor(
        tester,
        find.text(S().saleStatusDone),
        'the recorded sale in the list',
      );
      expect(
        (await api.sales()).where((s) => s['status'] == 'DONE'),
        hasLength(1),
      );
      await _wait(tester, 7);
      await binding.takeScreenshot('owner-11_sale_recorded');

      await tester.tap(find.text(S().saleStatusDone).first);
      await _waitFor(
        tester,
        find.text(S().cancelSaleTitle),
        'the cancel action in the sale details',
      );
      await _wait(tester, 4);
      await binding.takeScreenshot('owner-12_sale_details');
      await tester.tap(find.text(S().cancelSaleTitle));
      await _waitFor(
        tester,
        find.text(S().cancelSaleConfirm),
        'the cancel confirmation',
      );
      await tester.tap(find.text(S().cancelSaleTitle).last);

      await _waitGone(
        tester,
        find.text(S().cancelSaleTitle),
        'the cancel action after the sale was cancelled',
      );
      expect((await api.sales()).where((s) => s['status'] == 'DONE'), isEmpty);
      await _wait(tester, 4);
      await binding.takeScreenshot('owner-13_sale_cancelled');
    } catch (error, stack) {
      debugPrint('FLOW_ERROR: $error');
      debugPrint('FLOW_STACK: $stack');
      await binding.takeScreenshot('owner-ZZ_failure');
      if (_strict) rethrow;
    }
  });
}
