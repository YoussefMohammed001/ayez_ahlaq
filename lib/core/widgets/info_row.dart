import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/extensions/ext_theme.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool showDivider;
  final bool verified;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.showDivider = true,
    this.verified = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: showDivider
                ? context.colorScheme.outline
                : Colors.transparent,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18.r, color: context.colorScheme.onSurfaceVariant),
          SizedBox(width: 12.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    value,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      color: context.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (verified) ...[
                  SizedBox(width: 6.w),
                  Icon(
                    Icons.verified_rounded,
                    size: 15.r,
                    color: context.semantic.success,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
