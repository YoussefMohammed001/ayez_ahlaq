import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/member_salary.dart';
import '../helpers/salary_labels.dart';

class SalarySummaryCard extends StatelessWidget {
  final MemberSalary salary;

  const SalarySummaryCard({super.key, required this.salary});

  List<InfoRow> get _rows {
    final type = salary.type;
    final dailyRate = salary.dailyRate;
    final hourlyRate = salary.hourlyRate;
    final monthlyTotal = salary.monthlyTotal;
    final gross = salary.grossSalary;
    final deductions = salary.deductions;
    final net = salary.netSalary;

    return [
      if (type != null)
        InfoRow(
          icon: Icons.payments_outlined,
          label: S().salaryAmountRow,
          value:
              '${SalaryLabels.type(type)} · ${SalaryLabels.money(salary.amount ?? 0)}',
        ),
      if (dailyRate != null)
        InfoRow(
          icon: Icons.today_outlined,
          label: S().salaryDailyRateRow,
          value: SalaryLabels.money(dailyRate),
        ),
      if (hourlyRate != null)
        InfoRow(
          icon: Icons.schedule_rounded,
          label: S().salaryHourlyRateRow,
          value: SalaryLabels.money(hourlyRate),
        ),
      if (monthlyTotal != null)
        InfoRow(
          icon: Icons.calendar_month_outlined,
          label: S().salaryMonthlyTotalRow,
          value: SalaryLabels.money(monthlyTotal),
        ),
      InfoRow(
        icon: Icons.event_available_outlined,
        label: S().salaryDaysWorkedRow,
        value: S().salaryDaysWorkedValue(
          '${salary.daysWorked}',
          '${salary.workingDays}',
        ),
      ),
      InfoRow(
        icon: Icons.timer_outlined,
        label: S().salaryHoursWorkedRow,
        value: SalaryLabels.hours(salary.hoursWorked),
      ),
      if (salary.lateMinutes > 0)
        InfoRow(
          icon: Icons.running_with_errors_rounded,
          label: S().salaryLateMinutesRow,
          value: SalaryLabels.minutes(salary.lateMinutes),
        ),
      if (salary.earlyLeaveMinutes > 0)
        InfoRow(
          icon: Icons.logout_rounded,
          label: S().salaryEarlyLeaveRow,
          value: SalaryLabels.minutes(salary.earlyLeaveMinutes),
        ),
      if (salary.absentDays > 0)
        InfoRow(
          icon: Icons.person_off_outlined,
          label: S().salaryAbsentDaysRow,
          value: '${salary.absentDays}',
        ),
      if (gross != null)
        InfoRow(
          icon: Icons.account_balance_wallet_outlined,
          label: S().salaryGrossRow,
          value: SalaryLabels.money(gross),
        ),
      if (deductions != null && deductions > 0)
        InfoRow(
          icon: Icons.remove_circle_outline,
          label: S().salaryDeductionsRow,
          value: SalaryLabels.money(deductions),
        ),
      if (net != null)
        InfoRow(
          icon: Icons.savings_outlined,
          label: S().salaryNetRow,
          value: SalaryLabels.money(net),
          showDivider: false,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
      child: Column(children: _rows),
    );
  }
}
