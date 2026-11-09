import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../manager/member_salary_cubit.dart';
import '../manager/salary_view_state.dart';
import 'member_commission_card.dart';
import 'member_salary_actions.dart';
import 'salary_body.dart';
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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: S().salaryTitle),
              SalaryBody(
                state: state,
                cubit: cubit,
                notSetHint: S().salaryNotSetOwnerHint,
                actionsBuilder: (salary) => MemberSalaryActions(
                  hasSalary: salary.hasSalary,
                  onEdit: () => _edit(context),
                  onClear: () => _clear(context),
                ),
              ),
              const MemberCommissionCard(),
            ],
          );
        },
      ),
    );
  }
}
