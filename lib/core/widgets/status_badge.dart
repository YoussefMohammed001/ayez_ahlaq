import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'badge_tone.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final BadgeTone tone;
  final bool showDot;

  const StatusBadge({
    super.key,
    required this.label,
    required this.tone,
    this.showDot = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: tone.background(context),
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 5.r,
              height: 5.r,
              decoration: BoxDecoration(
                color: tone.foreground(context),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 5.w),
          ],
          Text(
            label,
            style: TextStyle(
              color: tone.foreground(context),
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
