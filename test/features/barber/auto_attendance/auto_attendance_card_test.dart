import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/analytics/app_analytics.dart';
import 'package:ayez_ahlaq/core/di/sl.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/get_current_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/use_cases/disable_auto_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/domain/use_cases/enable_auto_attendance_use_case.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/presentation/manager/auto_attendance_cubit.dart';
import 'package:ayez_ahlaq/features/barber/auto_attendance/presentation/widgets/auto_attendance_card.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import '../../../support/recording_analytics.dart';
import 'auto_attendance_test_doubles.dart';

void main() {
  late FakeStore store;
  late FakePermission permission;
  late FakeRegistrar registrar;

  setUp(() {
    store = FakeStore(enabled: false);
    permission = FakePermission();
    registrar = FakeRegistrar();
    final repo = FakeAttendanceRepo();
    sl.registerFactory(
      () => AutoAttendanceCubit(
        EnableAutoAttendanceUseCase(
          GetCurrentAttendanceUseCase(repo),
          permission,
          registrar,
          store,
        ),
        DisableAutoAttendanceUseCase(registrar, store),
        store,
        permission,
        AppAnalytics(RecordingAnalytics()),
      ),
    );
  });

  tearDown(() => sl.reset());

  Future<void> pumpCard(WidgetTester tester) async {
    tester.view.physicalSize = const Size(804, 1748);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(402, 874),
        builder: (_, __) => MaterialApp(
          theme: lightTheme,
          home: const Scaffold(body: AutoAttendanceCard()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  bool switchValue(WidgetTester tester) =>
      tester.widget<Switch>(find.byType(Switch)).value;

  testWidgets('explains the feature and starts off', (tester) async {
    await pumpCard(tester);

    expect(find.text(S().autoAttendanceTitle), findsOneWidget);
    expect(find.text(S().autoAttendanceSubtitle), findsOneWidget);
    expect(switchValue(tester), isFalse);
  });

  testWidgets('asks before requesting background location', (tester) async {
    await pumpCard(tester);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(find.text(S().autoAttendanceDialogBody), findsOneWidget);
    expect(permission.requests, 0);

    await tester.tap(find.text(S().cancel));
    await tester.pumpAndSettle();

    expect(permission.requests, 0);
    expect(switchValue(tester), isFalse);
  });

  testWidgets('agreeing requests the permission and turns it on', (
    tester,
  ) async {
    await pumpCard(tester);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    await tester.tap(find.text(S().autoAttendanceContinue));
    await tester.pumpAndSettle();

    expect(permission.requests, 1);
    expect(switchValue(tester), isTrue);
    expect(store.enabled, isTrue);
  });

  testWidgets('switching off removes the zone', (tester) async {
    store.enabled = true;
    await pumpCard(tester);
    expect(switchValue(tester), isTrue);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(switchValue(tester), isFalse);
    expect(registrar.clears, 1);
  });
}
