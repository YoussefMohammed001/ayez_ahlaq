import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../barber/salary/presentation/widgets/schedule_day_row.dart';
import '../../../team/presentation/manager/my_schedule_cubit.dart';
import '../../../team/presentation/manager/my_schedule_state.dart';
import '../helpers/sub_home_summary.dart';

class MyScheduleSection extends StatefulWidget {
  const MyScheduleSection({super.key});

  @override
  State<MyScheduleSection> createState() => _MyScheduleSectionState();
}

class _MyScheduleSectionState extends State<MyScheduleSection> {
  bool _expanded = false;

  Widget _notSet(BuildContext context) {
    return AppText(
      S().subScheduleNotSet,
      style: font13w500.copyWith(color: context.colorScheme.onSurfaceVariant),
    );
  }

  Widget _summary(BuildContext context, String today) {
    return InkWell(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Expanded(child: AppText(today, style: font14w600)),
            AppText(
              S().subScheduleWholeWeek,
              style: font12w500.copyWith(color: context.colorScheme.primary),
            ),
            Icon(
              _expanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              size: 20.r,
              color: context.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _week(MyScheduleState state) {
    final today = DateTime.now().weekday % DateTime.daysPerWeek;
    final days = [...state.days]
      ..sort((a, b) => a.dayOfWeek.compareTo(b.dayOfWeek));

    return Column(
      children: [
        for (final day in days)
          ScheduleDayRow(
            day: day,
            isToday: day.dayOfWeek % DateTime.daysPerWeek == today,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyScheduleCubit, MyScheduleState>(
      builder: (context, state) {
        if (state.days.isEmpty) return const SizedBox.shrink();

        final isSet = SubHomeSummary.isScheduleSet(state.days);
        final today = SubHomeSummary.todayHoursLabel(
          state.days,
          DateTime.now(),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: S().mySalaryScheduleTitle),
            AppCard(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
              child: !isSet
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: _notSet(context),
                    )
                  : Column(
                      children: [
                        _summary(context, today),
                        if (_expanded) _week(state),
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
