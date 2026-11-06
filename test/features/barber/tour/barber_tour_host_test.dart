import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage_keys.dart';
import 'package:ayez_ahlaq/core/di/sl.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/tour/presentation/manager/barber_tour_cubit.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:ayez_ahlaq/features/barber/tour/presentation/widgets/barber_tour_host.dart';
import 'package:ayez_ahlaq/shared/tour/tour_target.dart';

class _Harness {
  final cubit = BarberTourCubit();
  final target = GlobalKey();
  int homeRequests = 0;

  Widget build() => ScreenUtilInit(
    designSize: const Size(402, 874),
    builder: (_, __) => MaterialApp(
      theme: lightTheme,
      home: BarberTourHost(
        tourCubit: cubit,
        seenKey: PreferencesKeys.barberOwnerTourSeen,
        sequence: () => [target],
        onShowHome: () => homeRequests++,
        child: Scaffold(
          body: TourTarget(
            tourKey: target,
            title: 'عنوان الجولة',
            description: 'وصف',
            isLast: true,
            child: const Text('هدف'),
          ),
        ),
      ),
    ),
  );
}

void main() {
  late PreferencesStorage preferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    preferences = PreferencesStorage(await SharedPreferences.getInstance());
    if (sl.isRegistered<PreferencesStorage>()) {
      await sl.unregister<PreferencesStorage>();
    }
    sl.registerSingleton<PreferencesStorage>(preferences);
  });

  tearDown(() => sl.reset());

  testWidgets('starts by itself the first time and never again after', (
    tester,
  ) async {
    final harness = _Harness();
    await tester.pumpWidget(harness.build());
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('عنوان الجولة'), findsNothing);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('عنوان الجولة'), findsOneWidget);

    await tester.tap(find.text(S().tourDone));
    await tester.pumpAndSettle();
    expect(
      preferences.getBoolean(key: PreferencesKeys.barberOwnerTourSeen),
      isTrue,
    );

    await tester.pumpWidget(const SizedBox());
    final again = _Harness();
    await tester.pumpWidget(again.build());
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('عنوان الجولة'), findsNothing);
  });

  testWidgets('a request shows the home tab and replays the tour', (
    tester,
  ) async {
    await preferences.putBoolean(
      key: PreferencesKeys.barberOwnerTourSeen,
      value: true,
    );
    final harness = _Harness();
    await tester.pumpWidget(harness.build());
    await tester.pumpAndSettle();
    expect(find.text('عنوان الجولة'), findsNothing);

    harness.cubit.requestTour();
    await tester.pump();
    expect(harness.homeRequests, 1);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('عنوان الجولة'), findsOneWidget);
  });
}
