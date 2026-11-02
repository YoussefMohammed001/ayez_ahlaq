import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/team_attendance_member.dart';
import 'attendance_duration_label.dart';
import 'attendance_time_label.dart';

class TeamAttendanceRow extends StatelessWidget {
  final TeamAttendanceMember member;

  const TeamAttendanceRow({super.key, required this.member});

  String _details() {
    final today = S().attendanceTodayDuration(
      AttendanceDurationLabel.of(member.todayMinutes),
    );
    final checkIn = member.checkInAt;
    if (!member.onShift || checkIn == null) return today;
    return '${S().attendanceStartedAt(AttendanceTimeLabel.time(checkIn))} • $today';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.r),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        member.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                    if (member.owner) ...[
                      SizedBox(width: 8.w),
                      StatusBadge(
                        label: S().attendanceOwnerBadge,
                        tone: BadgeTone.gold,
                        showDot: false,
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  _details(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          StatusBadge(
            label: member.onShift
                ? S().attendanceOnShift
                : S().attendanceOffShift,
            tone: member.onShift ? BadgeTone.open : BadgeTone.muted,
          ),
        ],
      ),
    );
  }
}
