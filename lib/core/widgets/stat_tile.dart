import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_card.dart';
import '../../core/extensions/ext_theme.dart';

class StatTile extends StatelessWidget {
  final String value;
  final String label;
  final VoidCallback? onTap;
  final Color? valueColor;

  const StatTile({
    super.key,
    required this.value,
    required this.label,
    this.onTap,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      radius: 14.r,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      child: Column(
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.sp,
              color: valueColor ?? context.semantic.accentSoft,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.sp, color: context.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
