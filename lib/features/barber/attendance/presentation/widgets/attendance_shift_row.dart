import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/attendance_shift.dart';
import '../../domain/entities/attendance_status.dart';
import 'attendance_duration_label.dart';
import 'attendance_time_label.dart';

class AttendanceShiftRow extends StatelessWidget {
  final AttendanceShift shift;

  const AttendanceShiftRow({super.key, required this.shift});

  String _range() {
    final checkOut = shift.checkOutAt;
    final start = AttendanceTimeLabel.time(shift.checkInAt);
    if (checkOut == null) return '$start ← ${S().attendanceStillOpen}';
    return '$start ← ${AttendanceTimeLabel.time(checkOut)}';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final note = shift.adjustNote;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AttendanceTimeLabel.date(shift.checkInAt),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              if (shift.status == AttendanceStatus.adjusted)
                StatusBadge(label: S().attendanceAdjusted, tone: BadgeTone.info)
              else if (shift.isOpen)
                StatusBadge(label: S().attendanceOnShift, tone: BadgeTone.open),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            '${_range()} • ${AttendanceDurationLabel.of(shift.durationMinutes)}',
            style: TextStyle(fontSize: 12.5.sp, color: scheme.onSurfaceVariant),
          ),
          if (note != null && note.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              S().attendanceAdjustNote(note),
              style: TextStyle(fontSize: 12.sp, color: scheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}
