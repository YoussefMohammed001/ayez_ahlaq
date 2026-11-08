import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../generated/l10n.dart';
import '../helpers/salary_labels.dart';

class SalaryMonthSwitcher extends StatelessWidget {
  final DateTime month;
  final bool canShowNext;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const SalaryMonthSwitcher({
    super.key,
    required this.month,
    required this.canShowNext,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          tooltip: S().salaryPreviousMonth,
          onPressed: onPrevious,
          icon: const Icon(Icons.chevron_right_rounded),
        ),
        SizedBox(
          width: 120.w,
          child: Text(
            SalaryLabels.month(month),
            textAlign: TextAlign.center,
            style: font14w700,
          ),
        ),
        IconButton(
          tooltip: S().salaryNextMonth,
          onPressed: canShowNext ? onNext : null,
          icon: const Icon(Icons.chevron_left_rounded),
        ),
      ],
    );
  }
}
