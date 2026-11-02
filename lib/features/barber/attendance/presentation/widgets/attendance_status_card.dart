import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/current_attendance.dart';
import 'attendance_time_label.dart';
import 'shift_elapsed_text.dart';

class AttendanceStatusCard extends StatelessWidget {
  final CurrentAttendance current;
  final DateTime fetchedAt;

  const AttendanceStatusCard({
    super.key,
    required this.current,
    required this.fetchedAt,
  });

  @override
  Widget build(BuildContext context) {
    final shift = current.shift;
    final scheme = context.colorScheme;

    return AppCard(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                shift == null
                    ? Icons.hourglass_empty_rounded
                    : Icons.timer_outlined,
                color: scheme.primary,
                size: 22.r,
              ),
              SizedBox(width: 10.w),
              StatusBadge(
                label: shift == null
                    ? S().attendanceOffShift
                    : S().attendanceOnShift,
                tone: shift == null ? BadgeTone.muted : BadgeTone.open,
              ),
            ],
          ),
          if (shift != null) ...[
            SizedBox(height: 14.h),
            Text(
              S().attendanceStartedAt(
                AttendanceTimeLabel.time(shift.checkInAt),
              ),
              style: TextStyle(fontSize: 13.sp, color: scheme.onSurfaceVariant),
            ),
            SizedBox(height: 4.h),
            ShiftElapsedText(shift: shift, fetchedAt: fetchedAt),
          ],
        ],
      ),
    );
  }
}
