import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';

class SalaryNotSetCard extends StatelessWidget {
  final String hint;

  const SalaryNotSetCard({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          Icon(
            Icons.payments_outlined,
            size: 28.r,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 8.h),
          Text(S().salaryNotSet, style: font14w600),
          SizedBox(height: 4.h),
          Text(
            hint,
            textAlign: TextAlign.center,
            style: font12w400.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
