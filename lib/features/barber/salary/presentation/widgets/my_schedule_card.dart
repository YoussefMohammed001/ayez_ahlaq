import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../hours/presentation/manager/barber_hours_cubit.dart';
import '../../../hours/presentation/manager/barber_hours_state.dart';
import 'schedule_day_row.dart';

class MyScheduleCard extends StatelessWidget {
  final DateTime Function() clock;

  const MyScheduleCard({super.key, required this.clock});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberHoursCubit, BarberHoursState>(
      builder: (context, state) {
        if (state.days.isEmpty) return const SizedBox.shrink();

        final today = clock().weekday % DateTime.daysPerWeek;
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
          ],
        );
      },
    );
  }
}
