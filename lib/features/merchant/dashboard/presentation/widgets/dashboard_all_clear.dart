import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DashboardAllClear extends StatelessWidget {
  const DashboardAllClear({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: 18.r,
            color: context.semantic.success,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              S().everythingFine,
              style: font13w500.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
