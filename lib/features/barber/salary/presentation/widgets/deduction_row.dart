import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/deduction_kind.dart';
import '../../domain/entities/deduction_status.dart';
import '../../domain/entities/salary_deduction.dart';
import '../helpers/salary_labels.dart';
import 'deduction_actions.dart';

class DeductionRow extends StatelessWidget {
  final SalaryDeduction deduction;
  final VoidCallback onWaive;
  final VoidCallback onConfirm;

  const DeductionRow({
    super.key,
    required this.deduction,
    required this.onWaive,
    required this.onConfirm,
  });

  BadgeTone get _tone => switch (deduction.status) {
    DeductionStatus.pending => BadgeTone.closed,
    DeductionStatus.deducted => BadgeTone.danger,
    DeductionStatus.waived => BadgeTone.open,
  };

  String get _detail {
    final parts = [
      SalaryLabels.date(deduction.workDate),
      if (deduction.kind != DeductionKind.absent && deduction.minutes > 0)
        SalaryLabels.minutes(deduction.minutes),
      if (deduction.amount > 0) SalaryLabels.money(deduction.amount),
    ];
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final note = deduction.decisionNote;

    return AppCard(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${deduction.barberName} · ${SalaryLabels.kind(deduction.kind)}',
                  style: font14w700,
                ),
              ),
              StatusBadge(
                label: SalaryLabels.status(deduction.status),
                tone: _tone,
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            _detail,
            style: font12w400.copyWith(color: scheme.onSurfaceVariant),
          ),
          if (note != null) ...[
            SizedBox(height: 4.h),
            Text(
              S().deductionNoteValue(note),
              style: font12w400.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
          SizedBox(height: 12.h),
          DeductionActions(
            status: deduction.status,
            onWaive: onWaive,
            onConfirm: onConfirm,
          ),
        ],
      ),
    );
  }
}
