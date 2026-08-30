import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ayez_ahlaq/core/extensions/ext.dart';
import 'package:ayez_ahlaq/core/theme/styles.dart';

class TimePickerButton extends StatelessWidget {
  final String label;
  final String time;
  final ColorScheme cs;
  final VoidCallback onTap;

  const TimePickerButton({
    super.key,
    required this.label,
    required this.time,
    required this.cs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border.all(color: cs.tertiary.withValues(alpha: 0.25)),
          borderRadius: 8.bRadius,
        ),
        child: Row(
          children: [
            Icon(Icons.access_time_rounded, size: 14.r, color: cs.primary),
            6.wSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: font10w500.copyWith(
                      color: cs.tertiary.withValues(alpha: 0.7),
                    ),
                  ),
                  Text(time, style: font13w700.copyWith(color: cs.onSurface)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
