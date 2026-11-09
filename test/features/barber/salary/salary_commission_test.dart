import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/core/widgets/toggle_switch.dart';
import 'package:ayez_ahlaq/features/barber/salary/data/apis/member_commission_api.dart';
import 'package:ayez_ahlaq/features/barber/salary/data/models/member_salary_model.dart';
import 'package:ayez_ahlaq/features/barber/salary/data/repos/member_commission_repo.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/commission_rules.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/member_commission.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/salary_type.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/clear_member_salary_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/get_member_commission_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/get_member_salary_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/set_member_commission_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/set_member_salary_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/member_commission_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/member_commission_state.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/member_salary_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/widgets/member_commission_card.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/widgets/salary_summary_card.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'salary_test_doubles.dart';

const _realSalary = {
  'barberId': 10,
  'month': '2026-11',
  'type': 'DAILY',
  'amount': 250.0,
  'workingDays': 30,
  'scheduledHours': 719.5,
  'dailyRate': 250.0,
  'hourlyRate': 10.42,
  'monthlyTotal': 7500.0,
  'daysWorked': 5,
  'hoursWorked': 8.93,
  'earnedByDays': 1250.0,
  'earnedByHours': 93.05,
  'lateMinutes': 222,
  'earlyLeaveMinutes': 136,
  'absentDays': 1,
  'lateDeduction': 38.55,
  'earlyLeaveDeduction': 23.62,
  'absentDeduction': 0.0,
  'deductions': 62.17,
  'grossSalary': 1250.0,
  'netSalary': 1187.83,
  'pendingDecisions': 2,
  'commissionEnabled': true,
  'commissionPercent': 20.0,
  'commissionBookings': 3,
  'commissionBase': 900.0,
  'commissionAmount': 180.0,
  'totalPay': 1367.83,
};

class _CapturingApi implements MemberCommissionApi {
  Map<String, dynamic>? sent;

  @override
  Future<Either<Failure, dynamic>> get(int memberId) async => const Right({
    'data': {'enabled': false, 'percent': null},
  });

  @override
  Future<Either<Failure, dynamic>> set(
    int memberId, {
    required bool enabled,
    double? percent,
  }) async {
    sent = {'enabled': enabled, 'percent': percent};
    return Right({
      'data': {'enabled': enabled, 'percent': percent ?? 20},
    });
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  late FakeCommissionRepo repo;
  late FakeSalaryRepo salaryRepo;

  MemberCommissionCubit build() => MemberCommissionCubit(
    GetMemberCommissionUseCase(repo),
    SetMemberCommissionUseCase(repo),
  );

  setUp(() {
    repo = FakeCommissionRepo();
    salaryRepo = FakeSalaryRepo()
      ..type = SalaryType.daily
      ..amount = 250;
  });

  group('data', () {
    test('the salary view reads the real commission fields', () {
      final salary = MemberSalaryModel.fromJson({..._realSalary});

      expect(salary.commissionEnabled, isTrue);
      expect(salary.commissionPercent, 20);
      expect(salary.commissionBookings, 3);
      expect(salary.commissionBase, 900);
      expect(salary.commissionAmount, 180);
      expect(salary.totalPay, 1367.83);
      expect(salary.hasPay, isTrue);
    });

    test('a salary without commission fields has none', () {
      final salary = MemberSalaryModel.fromJson({
        ..._realSalary,
        'commissionEnabled': null,
        'commissionPercent': null,
        'totalPay': null,
      });

      expect(salary.commissionEnabled, isFalse);
      expect(salary.commissionPercent, isNull);
      expect(salary.totalPay, isNull);
    });

    test('commission alone counts as pay even with no salary', () {
      final salary = MemberSalaryModel.fromJson({
        ..._realSalary,
        'type': null,
        'amount': null,
      });

      expect(salary.hasSalary, isFalse);
      expect(salary.hasPay, isTrue);
    });

    test('turning it off sends only the flag', () async {
      final api = _CapturingApi();

      final result = await MemberCommissionRepo(api).set(10, enabled: false);

      expect(api.sent, {'enabled': false, 'percent': null});
      expect(result.getOrElse(() => throw StateError('x')).enabled, isFalse);
    });

    test('the percent is read as a number', () async {
      final result = await MemberCommissionRepo(_CapturingApi()).get(10);

      final commission = result.getOrElse(() => throw StateError('x'));
      expect(commission.enabled, isFalse);
      expect(commission.percent, isNull);
    });

    test('the percent must be above zero and at most one hundred', () {
      expect(CommissionRules.isValid(0), isFalse);
      expect(CommissionRules.isValid(0.5), isTrue);
      expect(CommissionRules.isValid(100), isTrue);
      expect(CommissionRules.isValid(100.1), isFalse);
    });
  });

  group('cubit', () {
    test('loads the saved commission', () async {
      repo.current = const MemberCommission(enabled: true, percent: 20);
      final cubit = build();

      await cubit.load(10);

      expect(cubit.state.status, MemberCommissionStatus.success);
      expect(cubit.state.commission.percent, 20);
    });

    test('a failed load is reported', () async {
      repo.failure = Failure('boom', 500, const {});
      final cubit = build();

      await cubit.load(10);

      expect(cubit.state.status, MemberCommissionStatus.failure);
      expect(cubit.state.errorMessage, 'boom');
    });

    test('turning it on with a percent saves both', () async {
      final cubit = build();
      await cubit.load(10);

      final saved = await cubit.turnOn(percent: 25);

      expect(saved, isTrue);
      expect(repo.lastSet, (enabled: true, percent: 25.0));
      expect(cubit.state.commission.enabled, isTrue);
      expect(cubit.state.isSaving, isFalse);
    });

    test('turning it off keeps the saved percent', () async {
      repo.current = const MemberCommission(enabled: true, percent: 20);
      final cubit = build();
      await cubit.load(10);

      await cubit.turnOff();

      expect(cubit.state.commission.enabled, isFalse);
      expect(cubit.state.commission.percent, 20);
    });

    test('a rejected save keeps the old state and shows why', () async {
      final cubit = build();
      await cubit.load(10);
      repo.failure = Failure('percent: bad', 400, const {});

      final saved = await cubit.turnOn(percent: 150);

      expect(saved, isFalse);
      expect(cubit.state.commission.enabled, isFalse);
      expect(cubit.state.errorMessage, 'percent: bad');
    });
  });

  group('card', () {
    Future<MemberSalaryCubit> pumpCard(WidgetTester tester) async {
      tester.view.physicalSize = const Size(804, 2400);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);

      final commission = build();
      await commission.load(10);
      final salary = MemberSalaryCubit(
        GetMemberSalaryUseCase(salaryRepo),
        SetMemberSalaryUseCase(salaryRepo),
        ClearMemberSalaryUseCase(salaryRepo),
      );
      await salary.loadMember(10);

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(402, 874),
          builder: (_, __) => MaterialApp(
            theme: lightTheme,
            home: Scaffold(
              body: MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: commission),
                  BlocProvider.value(value: salary),
                ],
                child: const MemberCommissionCard(),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      return salary;
    }

    testWidgets('off shows the hint and no edit button', (tester) async {
      await pumpCard(tester);

      expect(find.text(S().commissionOffHint), findsOneWidget);
      expect(find.text(S().commissionEditAction), findsNothing);
    });

    testWidgets('turning on for the first time asks for the percent', (
      tester,
    ) async {
      await pumpCard(tester);

      await tester.tap(find.byType(ToggleSwitch));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), '20');
      await tester.tap(find.text(S().save));
      await tester.pumpAndSettle();

      expect(repo.lastSet, (enabled: true, percent: 20.0));
      expect(find.text(S().commissionOnHint('20')), findsOneWidget);
      expect(find.text(S().commissionEditAction), findsOneWidget);
    });

    testWidgets('a saved percent is reused when turning back on', (
      tester,
    ) async {
      repo.current = const MemberCommission(enabled: false, percent: 15);
      await pumpCard(tester);

      await tester.tap(find.byType(ToggleSwitch));
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNothing);
      expect(repo.lastSet, (enabled: true, percent: null));
    });

    testWidgets('turning off needs no question', (tester) async {
      repo.current = const MemberCommission(enabled: true, percent: 20);
      await pumpCard(tester);

      await tester.tap(find.byType(ToggleSwitch));
      await tester.pumpAndSettle();

      expect(repo.lastSet, (enabled: false, percent: null));
      expect(find.text(S().commissionOffHint), findsOneWidget);
    });

    testWidgets('editing starts from the current percent', (tester) async {
      repo.current = const MemberCommission(enabled: true, percent: 20);
      await pumpCard(tester);

      await tester.tap(find.text(S().commissionEditAction));
      await tester.pumpAndSettle();

      expect(find.text('20'), findsOneWidget);
    });

    testWidgets('a percent outside 1 to 100 is refused', (tester) async {
      await pumpCard(tester);

      await tester.tap(find.byType(ToggleSwitch));
      await tester.pumpAndSettle();
      for (final text in ['0', '101', 'abc', '']) {
        await tester.enterText(find.byType(TextFormField), text);
        await tester.tap(find.text(S().save));
        await tester.pumpAndSettle();

        expect(
          find.text(S().commissionPercentInvalid),
          findsOneWidget,
          reason: text,
        );
      }
      expect(repo.lastSet, isNull);
    });

    testWidgets('a server rejection is not shown as saved', (tester) async {
      await pumpCard(tester);
      repo.failure = Failure('percent: bad', 400, const {});

      await tester.tap(find.byType(ToggleSwitch));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), '30');
      await tester.tap(find.text(S().save));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text(S().commissionOnHint('30')), findsNothing);
    });
  });

  group('summary', () {
    Future<void> pumpSummary(
      WidgetTester tester,
      Map<String, dynamic> json,
    ) async {
      tester.view.physicalSize = const Size(804, 3200);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(402, 874),
          builder: (_, __) => MaterialApp(
            theme: lightTheme,
            home: Scaffold(
              body: SingleChildScrollView(
                child: SalarySummaryCard(
                  salary: MemberSalaryModel.fromJson(json),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('shows the commission and the total pay', (tester) async {
      await pumpSummary(tester, {..._realSalary});

      expect(find.text(S().commissionPercentRow), findsOneWidget);
      expect(find.text(S().commissionBookingsRow), findsOneWidget);
      expect(find.text(S().commissionBaseRow), findsOneWidget);
      expect(find.text(S().commissionAmountRow), findsOneWidget);
      expect(find.text(S().salaryTotalPayRow), findsOneWidget);
      expect(find.text(S().commissionPercentValue('20')), findsOneWidget);
    });

    testWidgets('hides the commission when it is off', (tester) async {
      await pumpSummary(tester, {
        ..._realSalary,
        'commissionEnabled': false,
        'totalPay': null,
      });

      expect(find.text(S().commissionAmountRow), findsNothing);
      expect(find.text(S().salaryTotalPayRow), findsNothing);
      expect(find.text(S().salaryNetRow), findsOneWidget);
    });
  });
}
