import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/hours/presentation/widgets/day_name.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/salary_type.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/get_my_salary_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/my_salary_cubit.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'salary_member_doubles.dart';
import 'salary_test_doubles.dart';

void main() {
  late FakeSalaryRepo repo;
  late MySalaryCubit cubit;

  setUp(() {
    repo = FakeSalaryRepo()
      ..type = SalaryType.monthly
      ..amount = 6000;
    cubit = MySalaryCubit(
      GetMySalaryUseCase(repo),
      clock: () => DateTime.now(),
    );
  });

  Future<void> pump(WidgetTester tester, Widget home) async {
    tester.view.physicalSize = const Size(804, 3600);
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

  testWidgets('shows the week with the times and the day off', (tester) async {
    await cubit.load();
    await pump(tester, mySalaryScreen(salary: cubit));

    expect(find.text(S().mySalaryScheduleTitle), findsOneWidget);
    expect(
      find.text(S().scheduleTimeRange('10:00', '18:00')),
      findsNWidgets(5),
    );
    expect(find.text(S().scheduleTimeRange('12:00', '20:30')), findsOneWidget);
    expect(find.text(S().scheduleDayOff), findsOneWidget);
    for (final day in DayName.values) {
      expect(find.text(day.label()), findsOneWidget, reason: '$day');
    }
  });

  testWidgets('hides the schedule when it cannot be loaded', (tester) async {
    await cubit.load();
    await pump(
      tester,
      mySalaryScreen(
        salary: cubit,
        hours: FakeHoursRepo()..failure = Failure('x', 500, const {}),
      ),
    );

    expect(find.text(S().mySalaryScheduleTitle), findsNothing);
  });

  testWidgets('shows the scheduled hours next to the hours worked', (
    tester,
  ) async {
    await cubit.load();
    await pump(tester, mySalaryScreen(salary: cubit));

    expect(find.text(S().salaryScheduledHoursRow), findsOneWidget);
    expect(find.text(S().salaryHoursWorkedRow), findsOneWidget);
  });

  testWidgets('shows how long the member worked today and this month', (
    tester,
  ) async {
    await cubit.load();
    await pump(tester, mySalaryScreen(salary: cubit));

    expect(find.text(S().workedHoursTitle), findsOneWidget);
    expect(find.text(S().today), findsOneWidget);
    expect(find.text(S().attendanceHoursAndMinutes(1, 30)), findsNWidgets(2));
  });

  testWidgets('the today card goes away on a past month', (tester) async {
    await cubit.load();
    await pump(tester, mySalaryScreen(salary: cubit));

    await tester.tap(find.byIcon(Icons.chevron_left_rounded));
    await tester.pumpAndSettle();

    expect(find.text(S().workedHoursTitle), findsNothing);
    expect(find.text(S().mySalaryScheduleTitle), findsOneWidget);
  });
}
