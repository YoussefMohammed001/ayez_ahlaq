import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_config.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_setting_log_entry.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_settings.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/team_attendance_member.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/widgets/attendance_setting_log_row.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/widgets/attendance_settings_form.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/widgets/owner_attendance_links.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/widgets/team_attendance_row.dart';
import 'package:ayez_ahlaq/features/merchant/subscription/domain/entities/subscription.dart';
import 'package:ayez_ahlaq/features/merchant/subscription/presentation/manager/merchant_subscription_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/subscription/presentation/manager/merchant_subscription_state.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/widgets/merchant_team_attendance_section.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

class _Subscription extends Cubit<MerchantSubscriptionState>
    implements MerchantSubscriptionCubit {
  _Subscription(super.state);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

Widget _host(Widget child) => ScreenUtilInit(
  designSize: const Size(402, 874),
  builder: (_, _) => MaterialApp(
    theme: lightTheme,
    home: Scaffold(body: child),
  ),
);

Future<void> _section(WidgetTester tester, Subscription? subscription) async {
  await tester.pumpWidget(
    _host(
      BlocProvider<MerchantSubscriptionCubit>.value(
        value: _Subscription(
          MerchantSubscriptionState(subscription: subscription),
        ),
        child: const MerchantTeamAttendanceSection(),
      ),
    ),
  );
  await tester.pump();
}

const _enabledPlan = Subscription(
  hasSubscription: true,
  fee: 1500,
  autoCharge: true,
  attendanceEnabled: true,
);

const _plainPlan = Subscription(
  hasSubscription: true,
  fee: 1500,
  autoCharge: true,
);

void main() {
  group('the attendance section of the team screen', () {
    testWidgets('shows the two links when the plan has attendance', (
      tester,
    ) async {
      await _section(tester, _enabledPlan);

      expect(find.text(S().attendanceTeamNowTitle), findsOneWidget);
      expect(find.text(S().attendanceSettingsTitle), findsOneWidget);
      expect(find.text(S().ownerAttendanceLocked), findsNothing);
    });

    testWidgets('says it is not enabled when the plan lacks it', (
      tester,
    ) async {
      await _section(tester, _plainPlan);

      expect(find.text(S().ownerAttendanceLocked), findsOneWidget);
      expect(find.text(S().attendanceTeamNowTitle), findsNothing);
    });

    testWidgets('shows nothing until the subscription has loaded', (
      tester,
    ) async {
      await _section(tester, null);

      expect(find.text(S().ownerAttendanceLocked), findsNothing);
      expect(find.text(S().attendanceTeamNowTitle), findsNothing);
    });
  });

  group('owner attendance links', () {
    testWidgets('go to the routes they are given, not the barber ones', (
      tester,
    ) async {
      final visited = <String>[];
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const Scaffold(
              body: OwnerAttendanceLinks(
                teamRoute: Routes.merchantTeamAttendanceScreen,
                settingsRoute: Routes.merchantAttendanceSettingsScreen,
              ),
            ),
          ),
          for (final path in [
            Routes.merchantTeamAttendanceScreen,
            Routes.merchantAttendanceSettingsScreen,
          ])
            GoRoute(
              path: path,
              builder: (_, _) {
                visited.add(path);
                return const SizedBox();
              },
            ),
        ],
      );
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(402, 874),
          builder: (_, _) =>
              MaterialApp.router(theme: lightTheme, routerConfig: router),
        ),
      );

      await tester.tap(find.text(S().attendanceTeamNowTitle));
      await tester.pumpAndSettle();
      router.pop();
      await tester.pumpAndSettle();
      await tester.tap(find.text(S().attendanceSettingsTitle));
      await tester.pumpAndSettle();

      expect(visited, [
        Routes.merchantTeamAttendanceScreen,
        Routes.merchantAttendanceSettingsScreen,
      ]);
    });
  });

  group('settings form', () {
    testWidgets('opens the change log of the route it is given', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(804, 2400);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      final visited = <String>[];
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => Scaffold(
              body: SingleChildScrollView(
                child: AttendanceSettingsForm(
                  logRoute: Routes.merchantAttendanceSettingLogScreen,
                  isSubmitting: false,
                  onSave: (_, _) async {},
                  settings: const AttendanceSettings(
                    config: AttendanceConfig(
                      shopLat: 1,
                      shopLng: 2,
                      rangeMeters: 300,
                      enforced: false,
                    ),
                    updatedByName: null,
                    updatedAt: null,
                  ),
                ),
              ),
            ),
          ),
          GoRoute(
            path: Routes.merchantAttendanceSettingLogScreen,
            builder: (_, _) {
              visited.add(Routes.merchantAttendanceSettingLogScreen);
              return const SizedBox();
            },
          ),
        ],
      );
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(402, 874),
          builder: (_, _) =>
              MaterialApp.router(theme: lightTheme, routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(S().attendanceSettingsLogTitle));
      await tester.pumpAndSettle();

      expect(visited, [Routes.merchantAttendanceSettingLogScreen]);
    });
  });

  group('team attendance row', () {
    const member = TeamAttendanceMember(
      barberId: 4000014,
      name: 'Sub Test',
      owner: false,
      onShift: true,
      checkInAt: null,
      todayMinutes: 95,
    );

    testWidgets('is tappable only when it is given a handler', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _host(TeamAttendanceRow(member: member, onTap: () => taps++)),
      );

      await tester.tap(find.text('Sub Test'));

      expect(taps, 1);
    });

    testWidgets('still renders without a handler', (tester) async {
      await tester.pumpWidget(_host(const TeamAttendanceRow(member: member)));

      expect(find.text('Sub Test'), findsOneWidget);
    });
  });

  group('settings log row', () {
    AttendanceSettingLogEntry entry(String actor) => AttendanceSettingLogEntry(
      id: 1,
      actorName: actor,
      oldRangeMeters: null,
      newRangeMeters: 300,
      oldEnforced: false,
      newEnforced: true,
      createdAt: DateTime(2026, 11, 11, 12, 50),
    );

    testWidgets('leaves out the separator when there is no actor name', (
      tester,
    ) async {
      await tester.pumpWidget(_host(AttendanceSettingLogRow(entry: entry(''))));

      expect(find.textContaining(' • '), findsNothing);
      expect(find.textContaining('2026-11-11'), findsOneWidget);
    });

    testWidgets('keeps the actor name before the date when there is one', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(AttendanceSettingLogRow(entry: entry('Owner'))),
      );

      expect(find.textContaining('Owner • 2026-11-11'), findsOneWidget);
    });
  });
}
