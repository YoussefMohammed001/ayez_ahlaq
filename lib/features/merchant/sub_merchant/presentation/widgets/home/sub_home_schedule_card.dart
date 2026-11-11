import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../team/presentation/manager/my_schedule_cubit.dart';
import '../../../../team/presentation/manager/my_schedule_state.dart';
import '../../helpers/sub_home_summary.dart';
import 'sub_home_card.dart';
import 'sub_home_value_text.dart';

class SubHomeScheduleCard extends StatelessWidget {
  const SubHomeScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyScheduleCubit, MyScheduleState>(
      builder: (context, state) {
        if (!SubHomeSummary.isScheduleSet(state.days)) {
          return const SizedBox.shrink();
        }

        final label = SubHomeSummary.todayHoursLabel(
          state.days,
          DateTime.now(),
        );
        if (label.isEmpty) return const SizedBox.shrink();

        return SubHomeCard(
          icon: Icons.schedule_rounded,
          title: S().subHomeScheduleTitle,
          child: SubHomeValueText(label),
        );
      },
    );
  }
}
