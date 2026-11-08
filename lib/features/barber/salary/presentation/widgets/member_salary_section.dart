import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../manager/member_salary_cubit.dart';
import '../manager/salary_view_state.dart';
import 'member_salary_actions.dart';
import 'salary_month_switcher.dart';
import 'salary_not_set_card.dart';
import 'salary_summary_card.dart';
import 'set_salary_sheet.dart';

class MemberSalarySection extends StatelessWidget {
  const MemberSalarySection({super.key});

  void _edit(BuildContext context) {
    final cubit = context.read<MemberSalaryCubit>();
    final salary = cubit.state.salary;

    SetSalarySheet.show(
      context,
      type: salary?.type,
      amount: salary?.amount,
      onSubmit: (type, amount) async {
        final saved = await cubit.save(type: type, amount: amount);
        if (saved) showSuccess(S().salarySaved);
      },
    );
  }

  Future<void> _clear(BuildContext context) async {
    final cubit = context.read<MemberSalaryCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: S().salaryClearConfirmTitle,
      message: S().salaryClearConfirmMessage,
      confirmLabel: S().salaryClearAction,
      icon: Icons.money_off_csred_outlined,
    );
    if (!confirmed) return;

    if (await cubit.clear()) showSuccess(S().salaryCleared);
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<MemberSalaryCubit, SalaryViewState>(
      isBusy: (state) => state.isSaving,
      errorMessage: (state) => state.errorMessage,
      child: BlocBuilder<MemberSalaryCubit, SalaryViewState>(
        builder: (context, state) {
          final cubit = context.read<MemberSalaryCubit>();
          final salary = state.salary;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: S().salaryTitle),
              SalaryMonthSwitcher(
                month: state.month,
                canShowNext: state.canShowNext(cubit.clock()),
                onPrevious: cubit.previousMonth,
                onNext: cubit.nextMonth,
              ),
              SizedBox(height: 8.h),
              if (state.status == SalaryViewStatus.loading ||
                  state.status == SalaryViewStatus.initial)
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
                  SalaryNotSetCard(hint: S().salaryNotSetOwnerHint),
                SizedBox(height: 12.h),
                MemberSalaryActions(
                  hasSalary: salary.hasSalary,
                  onEdit: () => _edit(context),
                  onClear: () => _clear(context),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
