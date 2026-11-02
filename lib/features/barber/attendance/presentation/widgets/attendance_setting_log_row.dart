import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/attendance_setting_log_entry.dart';
import 'attendance_time_label.dart';

class AttendanceSettingLogRow extends StatelessWidget {
  final AttendanceSettingLogEntry entry;

  const AttendanceSettingLogRow({super.key, required this.entry});

  String _range(int? meters) =>
      meters == null ? S().attendanceNoRange : S().attendanceMeters(meters);

  String _enforced(bool value) =>
      value ? S().attendanceEnforceOn : S().attendanceEnforceOff;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final style = TextStyle(fontSize: 12.5.sp, color: scheme.onSurfaceVariant);

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${entry.actorName} • ${AttendanceTimeLabel.date(entry.createdAt)} ${AttendanceTimeLabel.time(entry.createdAt)}',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          if (entry.enforcedChanged) ...[
            SizedBox(height: 6.h),
            Text(
              S().attendanceLogEnforceChange(
                _enforced(entry.oldEnforced),
                _enforced(entry.newEnforced),
              ),
              style: style,
            ),
          ],
          if (entry.rangeChanged) ...[
            SizedBox(height: 4.h),
            Text(
              S().attendanceLogRangeChange(
                _range(entry.oldRangeMeters),
                _range(entry.newRangeMeters),
              ),
              style: style,
            ),
          ],
        ],
      ),
    );
  }
}
