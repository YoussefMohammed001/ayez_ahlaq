import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../attendance/presentation/manager/worked_hours_cubit.dart';
import '../../../attendance/presentation/widgets/worked_hours_card.dart';
import '../../../hours/presentation/manager/barber_hours_cubit.dart';
import '../../domain/entities/salary_month.dart';
import '../manager/my_salary_cubit.dart';
import '../manager/salary_view_state.dart';
import '../widgets/my_schedule_card.dart';
import '../widgets/salary_body.dart';

class MySalaryScreen extends StatelessWidget {
  const MySalaryScreen({super.key});

  Future<void> _refresh(BuildContext context) {
    context.read<WorkedHoursCubit>().load();
    context.read<BarberHoursCubit>().loadHours();
    return context.read<MySalaryCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().mySalaryTitle),
      body: BlocBuilder<MySalaryCubit, SalaryViewState>(
        builder: (context, state) {
          final cubit = context.read<MySalaryCubit>();
          final isCurrentMonth = SalaryMonth.isSameMonth(
            state.month,
            cubit.clock(),
          );

          return RefreshableStateView(
            onRefresh: () => _refresh(context),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isCurrentMonth) const WorkedHoursCard(),
                  SizedBox(height: 14.h),
                  SalaryBody(
                    state: state,
                    cubit: cubit,
                    notSetHint: S().salaryNotSetMemberHint,
                  ),
                  MyScheduleCard(clock: cubit.clock),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
