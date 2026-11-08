import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../domain/entities/member_salary.dart';
import '../manager/salary_view_cubit.dart';
import '../manager/salary_view_state.dart';
import 'salary_month_switcher.dart';
import 'salary_not_set_card.dart';
import 'salary_summary_card.dart';

class SalaryBody extends StatelessWidget {
  final SalaryViewState state;
  final SalaryViewCubit cubit;
  final String notSetHint;
  final Widget Function(MemberSalary salary)? actionsBuilder;

  const SalaryBody({
    super.key,
    required this.state,
    required this.cubit,
    required this.notSetHint,
    this.actionsBuilder,
  });

  bool get _isLoading =>
      state.status == SalaryViewStatus.loading ||
      state.status == SalaryViewStatus.initial;

  @override
  Widget build(BuildContext context) {
    final salary = state.salary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SalaryMonthSwitcher(
          month: state.month,
          canShowNext: state.canShowNext(cubit.clock()),
          onPrevious: cubit.previousMonth,
          onNext: cubit.nextMonth,
        ),
        SizedBox(height: 8.h),
        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else if (salary == null)
          AppErrorState(
            compact: true,
            message: state.errorMessage,
            onRetry: cubit.load,
          )
        else ...[
          if (salary.hasSalary)
            SalarySummaryCard(salary: salary)
          else
            SalaryNotSetCard(hint: notSetHint),
          if (actionsBuilder != null) ...[
            SizedBox(height: 12.h),
            actionsBuilder!(salary),
          ],
        ],
      ],
    );
  }
}
