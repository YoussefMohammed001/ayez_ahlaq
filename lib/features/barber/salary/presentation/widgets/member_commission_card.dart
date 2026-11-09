import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/toggle_switch.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../helpers/salary_labels.dart';
import '../manager/member_commission_cubit.dart';
import '../manager/member_commission_state.dart';
import '../manager/member_salary_cubit.dart';
import 'set_commission_sheet.dart';

class MemberCommissionCard extends StatelessWidget {
  const MemberCommissionCard({super.key});

  Future<void> _turnOn(BuildContext context, double? percent) async {
    final saved = await context.read<MemberCommissionCubit>().turnOn(
      percent: percent,
    );
    if (!context.mounted || !saved) return;

    showSuccess(S().commissionSaved);
    context.read<MemberSalaryCubit>().load();
  }

  Future<void> _turnOff(BuildContext context) async {
    final saved = await context.read<MemberCommissionCubit>().turnOff();
    if (!context.mounted || !saved) return;

    showSuccess(S().commissionTurnedOff);
    context.read<MemberSalaryCubit>().load();
  }

  void _askPercent(BuildContext context, double? current) {
    SetCommissionSheet.show(
      context,
      percent: current,
      onSubmit: (percent) => _turnOn(context, percent),
    );
  }

  void _toggle(BuildContext context, MemberCommissionState state) {
    final commission = state.commission;

    if (commission.enabled) {
      _turnOff(context);
    } else if (commission.percent == null) {
      _askPercent(context, null);
    } else {
      _turnOn(context, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return BusyErrorListener<MemberCommissionCubit, MemberCommissionState>(
      isBusy: (state) => state.isSaving,
      errorMessage: (state) => state.errorMessage,
      child: BlocBuilder<MemberCommissionCubit, MemberCommissionState>(
        builder: (context, state) {
          if (state.status != MemberCommissionStatus.success) {
            return const SizedBox.shrink();
          }

          final commission = state.commission;
          final percent = commission.percent;

          return AppCard(
            margin: EdgeInsets.only(top: 12.h),
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.percent_rounded,
                      color: scheme.primary,
                      size: 24.r,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S().commissionTitle, style: font14w700),
                          SizedBox(height: 2.h),
                          Text(
                            commission.enabled && percent != null
                                ? S().commissionOnHint(
                                    SalaryLabels.percent(percent),
                                  )
                                : S().commissionOffHint,
                            style: font12w400.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ToggleSwitch(
                      value: commission.enabled,
                      onTap: () => _toggle(context, state),
                    ),
                  ],
                ),
                if (commission.enabled)
                  TextButton(
                    onPressed: () => _askPercent(context, percent),
                    child: Text(S().commissionEditAction),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
