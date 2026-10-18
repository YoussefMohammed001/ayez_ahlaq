import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions/ext_theme.dart';
import '../../generated/l10n.dart';

class DiscountPercentBadge extends StatelessWidget {
  final int percent;

  const DiscountPercentBadge({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: context.semantic.warning,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Text(
        S().unitDiscountPercentLabel(percent),
        style: TextStyle(
          fontSize: 10.5.sp,
          fontWeight: FontWeight.w700,
          color: context.colorScheme.surfaceContainerLowest,
        ),
      ),
    );
  }
}
