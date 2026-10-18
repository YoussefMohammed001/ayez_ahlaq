import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class SameDayBookingWarning extends StatelessWidget {
  final String date;

  const SameDayBookingWarning({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final warning = context.semantic.warning;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: warning),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, size: 20.r, color: warning),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              S().sameDayBookingWarningMessage(date),
              style: TextStyle(
                fontSize: 12.sp,
                height: 1.6,
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
