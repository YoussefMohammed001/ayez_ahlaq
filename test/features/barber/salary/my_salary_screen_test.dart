import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/salary_type.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/get_my_salary_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/my_salary_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/pages/my_salary_screen.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/widgets/my_salary_home_card.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'salary_test_doubles.dart';

void main() {
  late FakeSalaryRepo repo;
  late MySalaryCubit cubit;

  setUp(() {
    repo = FakeSalaryRepo();
    cubit = MySalaryCubit(
      GetMySalaryUseCase(repo),
      clock: () => DateTime(2026, 11, 8),
    );
  });

  Future<void> pump(WidgetTester tester, Widget home) async {
    tester.view.physicalSize = const Size(804, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(402, 874),
        builder: (_, __) => MaterialApp(theme: lightTheme, home: home),
      ),
    );
    await tester.pumpAndSettle();
  }

  Widget screen() =>
      BlocProvider.value(value: cubit, child: const MySalaryScreen());

  testWidgets('a salary shows the figures without any edit actions', (
    tester,
  ) async {
    repo
      ..type = SalaryType.monthly
      ..amount = 6000;
    await cubit.load();
    await pump(tester, screen());

    expect(find.text(S().salaryNetRow), findsOneWidget);
    expect(find.text(S().salaryEditAction), findsNothing);
    expect(find.text(S().salaryClearAction), findsNothing);
  });

  testWidgets('no salary tells the member the owner has not set it', (
    tester,
  ) async {
    await cubit.load();
    await pump(tester, screen());

    expect(find.text(S().salaryNotSet), findsOneWidget);
    expect(find.text(S().salaryNotSetMemberHint), findsOneWidget);
    expect(find.text(S().salarySetAction), findsNothing);
  });

  testWidgets('a failure shows a retry that loads again', (tester) async {
    repo.failure = Failure('boom', 500, const {});
    await cubit.load();
    await pump(tester, screen());

    repo.failure = null;
    await tester.tap(find.text(S().retry));
    await tester.pumpAndSettle();

    expect(repo.calls, 2);
    expect(find.text(S().salaryNotSet), findsOneWidget);
  });

  testWidgets('going to the previous month asks for that month', (
    tester,
  ) async {
    await cubit.load();
    await pump(tester, screen());

    await tester.tap(find.byIcon(Icons.chevron_left_rounded));
    await tester.pumpAndSettle();

    expect(repo.requestedMonths.last, '2026-10');
  });

  testWidgets('the home card opens the salary screen', (tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const Scaffold(body: MySalaryHomeCard()),
        ),
        GoRoute(
          path: Routes.barberMySalaryScreen,
          builder: (_, __) => const Scaffold(body: Text('salary-page')),
        ),
      ],
    );
    await pump(tester, const SizedBox());
    tester.view.physicalSize = const Size(804, 2400);
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(402, 874),
        builder: (_, __) =>
            MaterialApp.router(theme: lightTheme, routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text(S().mySalaryTitle));
    await tester.pumpAndSettle();

    expect(find.text('salary-page'), findsOneWidget);
  });
}
