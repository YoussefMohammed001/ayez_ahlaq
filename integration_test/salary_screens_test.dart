import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ayez_ahlaq/bootstrap.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage_keys.dart';
import 'package:ayez_ahlaq/core/cache/secure_storage/app_flutter_secure_storage.dart';
import 'package:ayez_ahlaq/core/di/sl.dart';
import 'package:ayez_ahlaq/core/helpers/user_helpers.dart';
import 'package:ayez_ahlaq/core/routes/app_routes.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/core/widgets/primary_cta_button.dart';
import 'package:ayez_ahlaq/env/flavor.dart';
import 'package:ayez_ahlaq/features/barber/auth/domain/entities/barber_account_kind.dart';
import 'package:ayez_ahlaq/firebase_options_dev.dart';
import 'package:ayez_ahlaq/shared/user_type.dart';

const _role = String.fromEnvironment('ROLE', defaultValue: 'owner');
const _ownerPhone = '01008451421';
const _memberPhone = '01114151413';
const _password = '1234567';
const _memberId = 10;

Future<void> _wait(WidgetTester tester, [int seconds = 3]) async {
  for (var i = 0; i < seconds * 4; i++) {
    await tester.pump(const Duration(milliseconds: 250));
  }
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('salary screens as $_role', (tester) async {
    await appFlutterSecureStorage.deleteAll();
    await (await SharedPreferences.getInstance()).clear();
    await bootstrap(Flavor.dev, DefaultFirebaseOptions.currentPlatform);
    await _wait(tester, 3);

    final isOwner = _role == 'owner';
    await UserHelpers.setUserType(UserType.barber);
    await UserHelpers.setBarberAccountKind(
      isOwner ? BarberAccountKind.owner : BarberAccountKind.teamMember,
    );
    final prefs = sl<PreferencesStorage>();
    await prefs.putBoolean(key: PreferencesKeys.barberOwnerTourSeen, value: true);
    await prefs.putBoolean(key: PreferencesKeys.barberTeamTourSeen, value: true);

    await binding.convertFlutterSurfaceToImage();

    routes.go(Routes.barberLoginScreen);
    await _wait(tester, 2);

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), isOwner ? _ownerPhone : _memberPhone);
    await tester.enterText(fields.at(1), _password);
    await tester.tap(find.byType(PrimaryCtaButton).first);
    await _wait(tester, 10);
    await binding.takeScreenshot('$_role-01_home');

    if (isOwner) {
      routes.push(Routes.barberTeamScreen);
      await _wait(tester, 6);
      await binding.takeScreenshot('$_role-02_team');

      routes.push(Routes.barberTeamMemberDetailScreen, extra: _memberId);
      await _wait(tester, 8);
      await tester.drag(find.byType(ListView).first, const Offset(0, -700));
      await _wait(tester, 2);
      await binding.takeScreenshot('$_role-03_member_salary');

      routes.push(Routes.barberSalaryDeductionsScreen);
      await _wait(tester, 8);
      await binding.takeScreenshot('$_role-04_deductions');
    } else {
      routes.push(Routes.barberMySalaryScreen);
      await _wait(tester, 8);
      await binding.takeScreenshot('$_role-02_my_salary');
    }
  });
}
