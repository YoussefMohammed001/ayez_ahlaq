import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../barber/salary/presentation/widgets/schedule_day_row.dart';
import '../../../team/presentation/manager/my_schedule_cubit.dart';
import '../../../team/presentation/manager/my_schedule_state.dart';

class MyScheduleSection extends StatelessWidget {
  const MyScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyScheduleCubit, MyScheduleState>(
      builder: (context, state) {
        if (state.days.isEmpty) return const SizedBox.shrink();

        final today = DateTime.now().weekday % DateTime.daysPerWeek;
        final days = [...state.days]
          ..sort((a, b) => a.dayOfWeek.compareTo(b.dayOfWeek));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: S().mySalaryScheduleTitle),
            AppCard(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                children: [
                  for (final day in days)
                    ScheduleDayRow(
                      day: day,
                      isToday: day.dayOfWeek % DateTime.daysPerWeek == today,
                    ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
          ],
        );
      },
    );
  }
}
