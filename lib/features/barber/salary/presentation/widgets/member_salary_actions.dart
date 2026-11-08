import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';

class MemberSalaryActions extends StatelessWidget {
  final bool hasSalary;
  final VoidCallback onEdit;
  final VoidCallback onClear;

  const MemberSalaryActions({
    super.key,
    required this.hasSalary,
    required this.onEdit,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryCtaButton(
          label: hasSalary ? S().salaryEditAction : S().salarySetAction,
          onPressed: onEdit,
        ),
        if (hasSalary) ...[
          SizedBox(height: 4.h),
          TextButton(onPressed: onClear, child: Text(S().salaryClearAction)),
        ],
      ],
    );
  }
}
