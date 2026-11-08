import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/salary_type.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/clear_member_salary_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/get_member_salary_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/set_member_salary_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/member_salary_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/widgets/member_salary_section.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/widgets/set_salary_sheet.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'salary_test_doubles.dart';

void main() {
  late FakeSalaryRepo repo;
  late MemberSalaryCubit cubit;

  setUp(() {
    repo = FakeSalaryRepo();
    cubit = MemberSalaryCubit(
      GetMemberSalaryUseCase(repo),
      SetMemberSalaryUseCase(repo),
      ClearMemberSalaryUseCase(repo),
      clock: () => DateTime(2026, 11, 8),
    );
  });

  Future<void> pump(
    WidgetTester tester,
    Widget child, {
    bool settle = true,
  }) async {
    tester.view.physicalSize = const Size(804, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(402, 874),
        builder: (_, __) => MaterialApp(
          theme: lightTheme,
          home: Scaffold(body: SingleChildScrollView(child: child)),
        ),
      ),
    );
    if (settle) {
      await tester.pumpAndSettle();
    } else {
      await tester.pump();
    }
  }

  Widget section() =>
      BlocProvider.value(value: cubit, child: const MemberSalarySection());

  testWidgets('a member without a salary invites the owner to set one', (
    tester,
  ) async {
    await cubit.loadMember(10);
    await pump(tester, section());

    expect(find.text(S().salaryNotSet), findsOneWidget);
    expect(find.text(S().salarySetAction), findsOneWidget);
    expect(find.text(S().salaryClearAction), findsNothing);
  });

  testWidgets('a salary shows its figures and the edit and clear actions', (
    tester,
  ) async {
    repo
      ..type = SalaryType.daily
      ..amount = 250;
    await cubit.loadMember(10);
    await pump(tester, section());

    expect(find.text(S().salaryNetRow), findsOneWidget);
    expect(find.text(S().salaryEditAction), findsOneWidget);
    expect(find.text(S().salaryClearAction), findsOneWidget);
    expect(find.text(S().salaryNotSet), findsNothing);
  });

  testWidgets('shows a loader before the first answer', (tester) async {
    await pump(tester, section(), settle: false);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text(S().retry), findsNothing);
  });

  testWidgets('a failed load offers a retry', (tester) async {
    repo.failure = Failure('boom', 500, const {});
    await cubit.loadMember(10);
    await pump(tester, section());

    expect(find.text(S().retry), findsOneWidget);
  });

  testWidgets('the next month arrow is off on the current month', (
    tester,
  ) async {
    await cubit.loadMember(10);
    await pump(tester, section());

    final next = tester.widget<IconButton>(
      find.widgetWithIcon(IconButton, Icons.chevron_left_rounded),
    );
    expect(next.onPressed, isNull);
  });

  group('set salary sheet', () {
    Future<List<(SalaryType, double)>> openSheet(WidgetTester tester) async {
      final submitted = <(SalaryType, double)>[];
      await pump(
        tester,
        Builder(
          builder: (context) => TextButton(
            onPressed: () => SetSalarySheet.show(
              context,
              onSubmit: (type, amount) async => submitted.add((type, amount)),
            ),
            child: const Text('open'),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      return submitted;
    }

    testWidgets('an empty or zero amount is refused', (tester) async {
      final submitted = await openSheet(tester);

      await tester.tap(find.text(S().save));
      await tester.pumpAndSettle();
      expect(find.text(S().salaryAmountInvalid), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), '0');
      await tester.tap(find.text(S().save));
      await tester.pumpAndSettle();

      expect(find.text(S().salaryAmountInvalid), findsOneWidget);
      expect(submitted, isEmpty);
    });

    testWidgets('submits the chosen type and amount', (tester) async {
      final submitted = await openSheet(tester);

      await tester.tap(find.text(S().salaryTypeDaily));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), '250');
      await tester.tap(find.text(S().save));
      await tester.pumpAndSettle();

      expect(submitted, [(SalaryType.daily, 250.0)]);
    });

    testWidgets('the hint follows the chosen type', (tester) async {
      await openSheet(tester);

      expect(find.text(S().salaryMonthlyHint), findsOneWidget);

      await tester.tap(find.text(S().salaryTypeDaily));
      await tester.pumpAndSettle();

      expect(find.text(S().salaryDailyHint), findsOneWidget);
    });
  });
}
