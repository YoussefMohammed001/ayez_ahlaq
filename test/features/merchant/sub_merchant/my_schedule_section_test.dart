import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/entities/working_day.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/widgets/schedule_day_row.dart';
import 'package:ayez_ahlaq/features/merchant/sub_merchant/presentation/widgets/my_schedule_section.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/my_schedule_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/my_schedule_state.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

class _Schedule extends Cubit<MyScheduleState> implements MyScheduleCubit {
  _Schedule(super.state);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

Future<void> _open(WidgetTester tester, List<WorkingDay> days) async {
  tester.view.physicalSize = const Size(1200, 3600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(402, 874),
      builder: (_, _) => BlocProvider<MyScheduleCubit>.value(
        value: _Schedule(
          MyScheduleState(status: MyScheduleStatus.success, days: days),
        ),
        child: MaterialApp(
          theme: lightTheme,
          home: const Scaffold(body: MyScheduleSection()),
        ),
      ),
    ),
  );
  await tester.pump();
}

List<WorkingDay> _week({required bool open}) => [
  for (var day = 0; day < 7; day++)
    open
        ? WorkingDay(
            dayOfWeek: day,
            isOpen: true,
            openTime: '09:00:00',
            closeTime: '17:00:00',
          )
        : WorkingDay.closed(day),
];

void main() {
  testWidgets('nothing at all shows nothing', (tester) async {
    await _open(tester, const []);

    expect(find.text(S().mySalaryScheduleTitle), findsNothing);
  });

  testWidgets('a week that was never set is one clear message, not 7 rows', (
    tester,
  ) async {
    await _open(tester, _week(open: false));

    expect(find.text(S().subScheduleNotSet), findsOneWidget);
    expect(find.byType(ScheduleDayRow), findsNothing);
    expect(find.text(S().scheduleDayOff), findsNothing);
  });

  testWidgets('a set week starts collapsed on today and opens on tap', (
    tester,
  ) async {
    await _open(tester, _week(open: true));

    expect(find.text(S().scheduleTimeRange('09:00', '17:00')), findsOneWidget);
    expect(find.byType(ScheduleDayRow), findsNothing);

    await tester.tap(find.text(S().subScheduleWholeWeek));
    await tester.pump();

    expect(find.byType(ScheduleDayRow), findsNWidgets(7));

    await tester.tap(find.text(S().subScheduleWholeWeek));
    await tester.pump();

    expect(find.byType(ScheduleDayRow), findsNothing);
  });
}
