import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/attendance_config.dart';

class AttendanceRangeNote extends StatelessWidget {
  final AttendanceConfig config;

  const AttendanceRangeNote({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final range = config.rangeMeters;
    final required = config.enforced && range != null;

    return Row(
      children: [
        Icon(
          required ? Icons.my_location_rounded : Icons.location_off_outlined,
          size: 16.r,
          color: context.colorScheme.onSurfaceVariant,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            required
                ? S().attendanceRangeRequired(range)
                : S().attendanceRangeNotRequired,
            style: TextStyle(
              fontSize: 12.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
