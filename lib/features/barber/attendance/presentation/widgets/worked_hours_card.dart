import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';
import '../manager/worked_hours_cubit.dart';
import '../manager/worked_hours_state.dart';
import 'attendance_duration_label.dart';
import 'worked_hours_figure.dart';

class WorkedHoursCard extends StatelessWidget {
  const WorkedHoursCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkedHoursCubit, WorkedHoursState>(
      builder: (context, state) {
        if (!state.isVisible) return const SizedBox.shrink();

        return Padding(
          padding: EdgeInsets.only(top: 14.h),
          child: AppCard(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 20.r,
                      color: context.colorScheme.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text(S().workedHoursTitle, style: font14w600),
                  ],
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    WorkedHoursFigure(
                      label: S().today,
                      value: AttendanceDurationLabel.of(
                        state.hours.todayMinutes,
                      ),
                    ),
                    WorkedHoursFigure(
                      label: S().workedHoursThisMonth,
                      value: AttendanceDurationLabel.of(
                        state.hours.monthMinutes,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
