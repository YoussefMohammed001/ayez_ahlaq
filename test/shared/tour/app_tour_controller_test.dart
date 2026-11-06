import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage_keys.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:ayez_ahlaq/shared/tour/app_tour_controller.dart';
import 'package:ayez_ahlaq/shared/tour/tour_target.dart';

Future<void> _pump(WidgetTester tester, List<Widget> children) async {
  await tester.pumpWidget(_host(children));
  await tester.pumpAndSettle();
}

Widget _host(List<Widget> children) => ScreenUtilInit(
  designSize: const Size(402, 874),
  builder: (_, __) => MaterialApp(
    theme: lightTheme,
    home: Scaffold(body: Column(children: children)),
  ),
);

void main() {
  late PreferencesStorage preferences;
  late AppTourController controller;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    preferences = PreferencesStorage(await SharedPreferences.getInstance());
    controller = AppTourController(
      preferences,
      seenKey: PreferencesKeys.barberOwnerTourSeen,
    )..attach();
  });

  tearDown(() => controller.detach());

  testWidgets('walks through the mounted targets and remembers it finished', (
    tester,
  ) async {
    final first = GlobalKey();
    final second = GlobalKey();
    final notMounted = GlobalKey();

    await _pump(tester, [
      TourTarget(
        tourKey: first,
        title: 'عنوان أول',
        description: 'وصف أول',
        child: const Text('أ'),
      ),
      TourTarget(
        tourKey: second,
        title: 'عنوان ثان',
        description: 'وصف ثان',
        isLast: true,
        child: const Text('ب'),
      ),
    ]);

    expect(controller.hasBeenSeen, isFalse);
    expect(controller.start([first, notMounted, second]), isTrue);
    await tester.pumpAndSettle();

    expect(find.text('عنوان أول'), findsOneWidget);
    expect(find.text(S().tourSkip), findsOneWidget);

    await tester.tap(find.text(S().tourNext));
    await tester.pumpAndSettle();

    expect(find.text('عنوان ثان'), findsOneWidget);
    expect(find.text(S().tourSkip), findsNothing);

    await tester.tap(find.text(S().tourDone));
    await tester.pumpAndSettle();

    expect(find.text('عنوان ثان'), findsNothing);
    expect(controller.hasBeenSeen, isTrue);
  });

  testWidgets('skipping also counts as seen', (tester) async {
    final first = GlobalKey();

    await _pump(tester, [
      TourTarget(
        tourKey: first,
        title: 'عنوان',
        description: 'وصف',
        child: const Text('أ'),
      ),
    ]);

    controller.start([first]);
    await tester.pumpAndSettle();
    await tester.tap(find.text(S().tourSkip));
    await tester.pumpAndSettle();

    expect(find.text('عنوان'), findsNothing);
    expect(controller.hasBeenSeen, isTrue);
  });

  testWidgets('does nothing when no target is on screen', (tester) async {
    await _pump(tester, const []);

    expect(controller.start([GlobalKey()]), isFalse);
    expect(controller.hasBeenSeen, isFalse);
  });

  test('clearExcept keeps the chosen keys and drops the rest', () async {
    await preferences.putBoolean(
      key: PreferencesKeys.barberOwnerTourSeen,
      value: true,
    );
    await preferences.putString(
      key: PreferencesKeys.currentLanguage,
      value: 'en',
    );
    await preferences.putBoolean(
      key: PreferencesKeys.barberTeamTourSeen,
      value: true,
    );

    await preferences.clearExcept({
      PreferencesKeys.currentLanguage,
      PreferencesKeys.barberOwnerTourSeen,
    });

    expect(preferences.getCurrentLanguage(), 'en');
    expect(
      preferences.getBoolean(key: PreferencesKeys.barberOwnerTourSeen),
      isTrue,
    );
    expect(
      preferences.getBoolean(key: PreferencesKeys.barberTeamTourSeen),
      isFalse,
    );
  });

  testWidgets('an old controller leaving does not unregister the new one', (
    tester,
  ) async {
    final replacement = AppTourController(
      preferences,
      seenKey: PreferencesKeys.barberTeamTourSeen,
    )..attach();
    final target = GlobalKey();

    await _pump(tester, [
      TourTarget(
        tourKey: target,
        title: 'عنوان',
        description: 'وصف',
        isLast: true,
        child: const Text('أ'),
      ),
    ]);

    controller.detach();
    replacement.start([target]);
    await tester.pumpAndSettle();

    expect(find.text('عنوان'), findsOneWidget);
    replacement.detach();
  });
}
