import 'package:flutter/material.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/member_salary.dart';
import '../helpers/salary_labels.dart';

class SalaryCommissionRows {
  const SalaryCommissionRows._();

  static List<InfoRow> of(MemberSalary salary) {
    final percent = salary.commissionPercent;
    final totalPay = salary.totalPay;

    return [
      if (percent != null)
        InfoRow(
          icon: Icons.percent_rounded,
          label: S().commissionPercentRow,
          value: S().commissionPercentValue(SalaryLabels.percent(percent)),
        ),
      InfoRow(
        icon: Icons.content_cut_rounded,
        label: S().commissionBookingsRow,
        value: '${salary.commissionBookings}',
      ),
      InfoRow(
        icon: Icons.receipt_long_outlined,
        label: S().commissionBaseRow,
        value: SalaryLabels.money(salary.commissionBase),
      ),
      InfoRow(
        icon: Icons.add_card_outlined,
        label: S().commissionAmountRow,
        value: SalaryLabels.money(salary.commissionAmount),
        showDivider: totalPay != null,
      ),
      if (totalPay != null)
        InfoRow(
          icon: Icons.account_balance_outlined,
          label: S().salaryTotalPayRow,
          value: SalaryLabels.money(totalPay),
          showDivider: false,
        ),
    ];
  }
}
