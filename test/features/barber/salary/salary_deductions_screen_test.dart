import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ayez_ahlaq/core/di/sl.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/core/widgets/filter_chip_row.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/deduction_status.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/decide_deduction_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/get_deduction_grace_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/get_pending_deductions_count_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/get_salary_deductions_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/set_deduction_grace_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/deduction_grace_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/pending_deductions_count_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/salary_deductions_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/pages/salary_deductions_screen.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/widgets/deduction_actions.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/widgets/deductions_entry_card.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/widgets/grace_setting_sheet.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'salary_test_doubles.dart';

void main() {
  late FakeDeductionsRepo repo;

  SalaryDeductionsCubit build() => SalaryDeductionsCubit(
    GetSalaryDeductionsUseCase(repo),
    DecideDeductionUseCase(repo),
    GetPendingDeductionsCountUseCase(repo),
  );

  setUp(() {
    repo = FakeDeductionsRepo([
      deductionOf(3),
      deductionOf(2, status: DeductionStatus.deducted),
      deductionOf(1, status: DeductionStatus.waived, note: 'ok'),
    ])..pending = 1;
  });

  Future<void> pump(
    WidgetTester tester,
    Widget home, {
    bool settle = true,
  }) async {
    tester.view.physicalSize = const Size(804, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(402, 874),
        builder: (_, __) => MaterialApp(theme: lightTheme, home: home),
      ),
    );
    settle ? await tester.pumpAndSettle() : await tester.pump();
  }

  Widget screen(SalaryDeductionsCubit cubit) =>
      BlocProvider.value(value: cubit, child: const SalaryDeductionsScreen());

  group('screen', () {
    testWidgets('lists every deduction with its status', (tester) async {
      final cubit = build()..load();
      await pump(tester, screen(cubit));

      expect(find.text(S().deductionStatusPending), findsWidgets);
      expect(find.text(S().deductionStatusDeducted), findsWidgets);
      expect(find.text(S().deductionStatusWaived), findsWidgets);
      expect(find.text(S().deductionNoteValue('ok')), findsOneWidget);
      expect(find.text(S().deductionsAutoNote), findsOneWidget);
    });

    testWidgets('an empty list explains itself', (tester) async {
      repo = FakeDeductionsRepo([]);
      final cubit = build()..load();
      await pump(tester, screen(cubit));

      expect(find.text(S().deductionsEmpty), findsOneWidget);
    });

    testWidgets('a failure offers a retry', (tester) async {
      repo.failure = Failure('boom', 500, const {});
      final cubit = build()..load();
      await pump(tester, screen(cubit));

      expect(find.text(S().retry), findsOneWidget);
    });

    testWidgets('choosing a filter shows only that status', (tester) async {
      final cubit = build()..load();
      await pump(tester, screen(cubit));

      final chip = find.descendant(
        of: find.byType(FilterChipRow<DeductionStatus>),
        matching: find.text(S().deductionFilterDeducted),
      );
      await tester.ensureVisible(chip);
      await tester.pumpAndSettle();
      await tester.tap(chip);
      await tester.pumpAndSettle();

      expect(find.text(S().deductionWaiveAction), findsOneWidget);
      expect(find.text(S().deductionConfirmAction), findsNothing);
      expect(repo.requests.last.status, DeductionStatus.deducted);
    });

    testWidgets('waiving asks for a note and sends the decision', (
      tester,
    ) async {
      final cubit = build()..load();
      await pump(tester, screen(cubit));

      await tester.tap(find.text(S().deductionWaiveAction).first);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'عذر');
      await tester.tap(
        find.descendant(
          of: find.byType(BottomSheet),
          matching: find.text(S().deductionWaiveAction),
        ),
      );
      await tester.pumpAndSettle();

      expect(repo.lastDecision, (id: 3, waive: true, note: 'عذر'));
    });

    testWidgets('confirming without a note sends no note', (tester) async {
      final cubit = build()..load();
      await pump(tester, screen(cubit));

      await tester.tap(find.text(S().deductionConfirmAction).first);
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byType(BottomSheet),
          matching: find.text(S().deductionConfirmAction),
        ),
      );
      await tester.pumpAndSettle();

      expect(repo.lastDecision, (id: 3, waive: false, note: null));
    });
  });

  group('actions', () {
    Future<void> pumpActions(WidgetTester tester, DeductionStatus status) =>
        pump(
          tester,
          Scaffold(
            body: DeductionActions(
              status: status,
              onWaive: () {},
              onConfirm: () {},
            ),
          ),
        );

    testWidgets('an undecided deduction can go either way', (tester) async {
      await pumpActions(tester, DeductionStatus.pending);

      expect(find.text(S().deductionWaiveAction), findsOneWidget);
      expect(find.text(S().deductionConfirmAction), findsOneWidget);
    });

    testWidgets('a deducted one can only be waived', (tester) async {
      await pumpActions(tester, DeductionStatus.deducted);

      expect(find.text(S().deductionWaiveAction), findsOneWidget);
      expect(find.text(S().deductionConfirmAction), findsNothing);
    });

    testWidgets('a waived one can only be confirmed', (tester) async {
      await pumpActions(tester, DeductionStatus.waived);

      expect(find.text(S().deductionWaiveAction), findsNothing);
      expect(find.text(S().deductionConfirmAction), findsOneWidget);
    });
  });

  group('grace sheet', () {
    DeductionGraceCubit graceCubit() => DeductionGraceCubit(
      GetDeductionGraceUseCase(repo),
      SetDeductionGraceUseCase(repo),
    );

    Future<DeductionGraceCubit> openSheet(WidgetTester tester) async {
      final cubit = graceCubit()..load();
      await pump(
        tester,
        Scaffold(
          body: BlocProvider.value(
            value: cubit,
            child: const GraceSettingSheet(),
          ),
        ),
      );
      return cubit;
    }

    testWidgets('shows the saved minutes', (tester) async {
      repo.grace = 15;
      await openSheet(tester);

      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('a number above 120 is refused', (tester) async {
      await openSheet(tester);

      await tester.enterText(find.byType(TextFormField), '500');
      await tester.tap(find.text(S().save));
      await tester.pumpAndSettle();

      expect(find.text(S().graceInvalid), findsOneWidget);
      expect(repo.grace, 0);
    });

    testWidgets('a valid number is saved', (tester) async {
      await openSheet(tester);

      await tester.enterText(find.byType(TextFormField), '10');
      await tester.tap(find.text(S().save));
      await tester.pump();

      expect(repo.grace, 10);
    });
  });

  group('entry card', () {
    setUp(() {
      sl.registerFactory(
        () =>
            PendingDeductionsCountCubit(GetPendingDeductionsCountUseCase(repo)),
      );
    });

    tearDown(() => sl.reset());

    testWidgets('shows how many wait for a decision', (tester) async {
      repo.pending = 3;
      await pump(tester, const Scaffold(body: DeductionsEntryCard()));

      expect(find.text(S().deductionsEntryPending('3')), findsOneWidget);
    });

    testWidgets('says so when nothing waits', (tester) async {
      repo.pending = 0;
      await pump(tester, const Scaffold(body: DeductionsEntryCard()));

      expect(find.text(S().deductionsEntryNone), findsOneWidget);
    });

    testWidgets('opens the deductions screen and refreshes the count', (
      tester,
    ) async {
      repo.pending = 2;
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const Scaffold(body: DeductionsEntryCard()),
          ),
          GoRoute(
            path: Routes.barberSalaryDeductionsScreen,
            builder: (context, __) => Scaffold(
              body: TextButton(
                onPressed: () {
                  repo.pending = 0;
                  context.pop();
                },
                child: const Text('back'),
              ),
            ),
          ),
        ],
      );
      tester.view.physicalSize = const Size(804, 2400);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(402, 874),
          builder: (_, __) =>
              MaterialApp.router(theme: lightTheme, routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(S().deductionsEntryTitle));
      await tester.pumpAndSettle();
      await tester.tap(find.text('back'));
      await tester.pumpAndSettle();

      expect(find.text(S().deductionsEntryNone), findsOneWidget);
    });
  });
}
