import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ayez_ahlaq/bootstrap.dart';
import 'package:ayez_ahlaq/core/cache/secure_storage/app_flutter_secure_storage.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage_keys.dart';
import 'package:ayez_ahlaq/core/di/sl.dart';
import 'package:ayez_ahlaq/core/helpers/user_helpers.dart';
import 'package:ayez_ahlaq/core/routes/app_routes.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/core/widgets/primary_cta_button.dart';
import 'package:ayez_ahlaq/env/flavor.dart';
import 'package:ayez_ahlaq/firebase_options_dev.dart';
import 'package:ayez_ahlaq/shared/user_type.dart';

const _prefix = String.fromEnvironment('SHOT_PREFIX', defaultValue: 'shot');
const _phone = String.fromEnvironment('BARBER_PHONE', defaultValue: '01008451421');
const _password = String.fromEnvironment('BARBER_PASSWORD', defaultValue: '1234567');

const _screens = <(String, String)>[
  ('shop_menu', Routes.barberShopMenuScreen),
  ('store_sales_menu', Routes.barberStoreAndSalesMenuScreen),
  ('financial_menu', Routes.barberFinancialMenuScreen),
  ('settings_menu', Routes.barberAppSettingsMenuScreen),
  ('support_menu', Routes.barberSupportMenuScreen),
  ('help', Routes.barberHelpScreen),
  ('account_menu', Routes.barberAccountMenuScreen),
  ('profile_details', Routes.barberProfileDetailsScreen),
  ('services', Routes.barberServicesScreen),
  ('hours', Routes.barberHoursScreen),
  ('documents', Routes.barberDocumentsScreen),
  ('reviews', Routes.barberReviewsScreen),
  ('team', Routes.barberTeamScreen),
  ('attendance', Routes.barberAttendanceScreen),
  ('notifications', Routes.barberNotificationsScreen),
  ('wallet', Routes.barberWalletScreen),
  ('subscription', Routes.barberSubscriptionScreen),
  ('discounts', Routes.barberDiscountsScreen),
  ('drinks', Routes.barberDrinksScreen),
  ('invite', Routes.barberInviteScreen),
  ('store_merchants', Routes.barberStoreMerchantsScreen),
  ('store_cart', Routes.barberStoreCartScreen),
  ('storefront', Routes.barberStorefrontHomeScreen),
  ('broadcast', Routes.barberBroadcastScreen),
  ('home_service_settings', Routes.barberHomeServiceSettingsScreen),
];

Future<void> _wait(WidgetTester tester, [int seconds = 3]) async {
  for (var i = 0; i < seconds * 4; i++) {
    await tester.pump(const Duration(milliseconds: 250));
  }
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('barber flow at this screen size', (tester) async {
    await appFlutterSecureStorage.deleteAll();
    await (await SharedPreferences.getInstance()).clear();
    await bootstrap(Flavor.dev, DefaultFirebaseOptions.currentPlatform);
    await _wait(tester, 3);

    await UserHelpers.setUserType(UserType.barber);
    final prefs = sl<PreferencesStorage>();
    await prefs.putBoolean(key: PreferencesKeys.barberOwnerTourSeen, value: true);
    await prefs.putBoolean(key: PreferencesKeys.barberTeamTourSeen, value: true);

    await binding.convertFlutterSurfaceToImage();

    routes.go(Routes.barberLoginScreen);
    await _wait(tester, 2);

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), _phone);
    await tester.enterText(fields.at(1), _password);
    await binding.takeScreenshot('$_prefix-00_login');
    await tester.tap(find.byType(PrimaryCtaButton).first);
    await _wait(tester, 8);

    await _wait(tester, 4);
    await binding.takeScreenshot('$_prefix-tab0_home');

    const tabs = [
      ('tab1_bookings', Icons.event_available_rounded),
      ('tab2_storefront', Icons.storefront_outlined),
      ('tab3_account', Icons.person_rounded),
    ];
    for (final (name, icon) in tabs) {
      await tester.tap(find.byIcon(icon).first);
      await _wait(tester, 4);
      await binding.takeScreenshot('$_prefix-$name');
    }

    for (final (name, path) in _screens) {
      routes.go(Routes.barberShell);
      await _wait(tester, 1);
      routes.push(path);
      await _wait(tester, 8);
      await binding.takeScreenshot('$_prefix-$name');
    }
  });
}
