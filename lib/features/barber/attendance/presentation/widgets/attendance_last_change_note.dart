import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/attendance_settings.dart';
import 'attendance_time_label.dart';

class AttendanceLastChangeNote extends StatelessWidget {
  final AttendanceSettings settings;

  const AttendanceLastChangeNote({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    final name = settings.updatedByName;
    final at = settings.updatedAt;
    if (name == null || at == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Text(
        S().attendanceLastChange(
          name,
          '${AttendanceTimeLabel.date(at)} ${AttendanceTimeLabel.time(at)}',
        ),
        style: TextStyle(
          fontSize: 11.5.sp,
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
