import 'package:ayez_ahlaq/core/di/sl.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/routes/modules/barber_attendance_routes.dart';
import 'package:ayez_ahlaq/core/routes/modules/barber_salary_routes.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/core/session/session_scope.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/attendance_setting_log_cubit.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/attendance_setting_log_state.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/attendance_settings_cubit.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/attendance_settings_state.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/attendance_team_cubit.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/attendance_team_state.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/pages/attendance_setting_log_screen.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/pages/attendance_settings_screen.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/pages/attendance_team_screen.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/entities/money_pin_reset_status.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/repos/i_barber_money_pin_repo.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/use_cases/change_money_pin_use_case.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/use_cases/check_money_pin_use_case.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/use_cases/get_money_pin_reset_status_use_case.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/use_cases/request_money_pin_reset_use_case.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/use_cases/setup_money_pin_use_case.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/use_cases/verify_money_pin_use_case.dart';
import 'package:ayez_ahlaq/features/barber/money/presentation/manager/money_pin_cubit.dart';
import 'package:ayez_ahlaq/features/barber/profile/domain/entities/barber_profile.dart';
import 'package:ayez_ahlaq/features/barber/profile/presentation/manager/barber_profile_cubit.dart';
import 'package:ayez_ahlaq/features/barber/profile/presentation/manager/barber_profile_state.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/salary_deductions_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/salary_deductions_state.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/pages/salary_deductions_screen.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class _PinRepo implements IBarberMoneyPinRepo {
  @override
  Future<Either<Failure, bool>> hasPin() async => const Right(true);

  @override
  Future<Either<Failure, void>> setup(String pin) async => const Right(null);

  @override
  Future<Either<Failure, void>> verify(String pin) async =>
      pin == '1234' ? const Right(null) : Left(Failure('wrong', 400, const {}));

  @override
  Future<Either<Failure, void>> change({
    required String currentPin,
    required String newPin,
  }) async => const Right(null);

  @override
  Future<Either<Failure, MoneyPinResetStatus>> getResetRequestStatus() async =>
      const Right(MoneyPinResetStatus(pending: false));

  @override
  Future<Either<Failure, MoneyPinResetStatus>> sendResetRequest() async =>
      const Right(MoneyPinResetStatus(pending: true));
}

class _Profile extends Cubit<BarberProfileState> implements BarberProfileCubit {
  _Profile(bool owner)
    : super(
        BarberProfileState(
          status: BarberProfileStatus.success,
          profile: BarberProfile(
            id: 1,
            name: 'x',
            phoneNumber: '0100',
            shopId: 3,
            shopName: 'shop',
            owner: owner,
            active: true,
            servesClients: true,
            mustChangePassword: false,
            rating: 0,
            ratingCount: 0,
          ),
        ),
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _AttendanceTeam extends Cubit<AttendanceTeamState>
    implements AttendanceTeamCubit {
  _AttendanceTeam() : super(const AttendanceTeamState());

  @override
  Future<void> load() async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _Settings extends Cubit<AttendanceSettingsState>
    implements AttendanceSettingsCubit {
  _Settings() : super(const AttendanceSettingsState());

  @override
  Future<void> load() async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _Log extends Cubit<AttendanceSettingLogState>
    implements AttendanceSettingLogCubit {
  _Log() : super(const AttendanceSettingLogState());

  @override
  Future<void> load() async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _Deductions extends Cubit<SalaryDeductionsState>
    implements SalaryDeductionsCubit {
  _Deductions() : super(const SalaryDeductionsState());

  @override
  Future<void> load() async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

Future<void> _openRoute(
  WidgetTester tester, {
  required List<RouteBase> routes,
  required String path,
  required bool owner,
}) async {
  await sl.reset();
  SessionScope.reset();
  final repo = _PinRepo();
  final pin = MoneyPinCubit(
    CheckMoneyPinUseCase(repo),
    SetupMoneyPinUseCase(repo),
    VerifyMoneyPinUseCase(repo),
    ChangeMoneyPinUseCase(repo),
    GetMoneyPinResetStatusUseCase(repo),
    RequestMoneyPinResetUseCase(repo),
  );
  sl.registerFactory<MoneyPinCubit>(() => pin);
  sl.registerFactory<BarberProfileCubit>(() => _Profile(owner));
  sl.registerFactory<AttendanceTeamCubit>(_AttendanceTeam.new);
  sl.registerFactory<AttendanceSettingsCubit>(_Settings.new);
  sl.registerFactory<AttendanceSettingLogCubit>(_Log.new);
  sl.registerFactory<SalaryDeductionsCubit>(_Deductions.new);
  addTearDown(SessionScope.reset);

  tester.view.physicalSize = const Size(1200, 2600);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);

  final router = GoRouter(
    initialLocation: path,
    routes: [routes.firstWhere((r) => r is GoRoute && r.path == path)],
  );
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(402, 874),
      builder: (_, _) =>
          MaterialApp.router(theme: lightTheme, routerConfig: router),
    ),
  );
  await tester.pump();
  await tester.pump();
}

void main() {
  group('the attendance of the team', () {
    testWidgets('asks the owner for the PIN before showing anything', (
      tester,
    ) async {
      await _openRoute(
        tester,
        routes: barberAttendanceRoutes,
        path: Routes.barberAttendanceTeamScreen,
        owner: true,
      );

      expect(find.byType(AttendanceTeamScreen), findsNothing);
      expect(find.byType(Pinput), findsOneWidget);
      expect(find.text(S().teamPinEnterTitle), findsOneWidget);
    });

    testWidgets('opens after the right PIN', (tester) async {
      await _openRoute(
        tester,
        routes: barberAttendanceRoutes,
        path: Routes.barberAttendanceTeamScreen,
        owner: true,
      );

      await tester.enterText(find.byType(Pinput), '1234');
      await tester.pump();
      await tester.tap(find.text(S().moneyPinConfirmAction));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(AttendanceTeamScreen), findsOneWidget);
    });

    testWidgets('does not ask a team member', (tester) async {
      await _openRoute(
        tester,
        routes: barberAttendanceRoutes,
        path: Routes.barberAttendanceTeamScreen,
        owner: false,
      );

      expect(find.byType(AttendanceTeamScreen), findsOneWidget);
      expect(find.byType(Pinput), findsNothing);
    });
  });

  group('the attendance settings', () {
    testWidgets('are behind the PIN for the owner', (tester) async {
      await _openRoute(
        tester,
        routes: barberAttendanceRoutes,
        path: Routes.barberAttendanceSettingsScreen,
        owner: true,
      );

      expect(find.byType(AttendanceSettingsScreen), findsNothing);
      expect(find.byType(Pinput), findsOneWidget);
    });

    testWidgets('and so is their change log', (tester) async {
      await _openRoute(
        tester,
        routes: barberAttendanceRoutes,
        path: Routes.barberAttendanceSettingLogScreen,
        owner: true,
      );

      expect(find.byType(AttendanceSettingLogScreen), findsNothing);
      expect(find.byType(Pinput), findsOneWidget);
    });

    testWidgets('a team member is not asked', (tester) async {
      await _openRoute(
        tester,
        routes: barberAttendanceRoutes,
        path: Routes.barberAttendanceSettingsScreen,
        owner: false,
      );

      expect(find.byType(Pinput), findsNothing);
    });
  });

  group('the salary deductions', () {
    testWidgets('are behind the PIN for the owner', (tester) async {
      await _openRoute(
        tester,
        routes: barberSalaryRoutes,
        path: Routes.barberSalaryDeductionsScreen,
        owner: true,
      );

      expect(find.byType(SalaryDeductionsScreen), findsNothing);
      expect(find.byType(Pinput), findsOneWidget);
    });
  });
}
