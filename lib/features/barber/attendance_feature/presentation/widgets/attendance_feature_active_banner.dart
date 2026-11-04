import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../generated/l10n.dart';
import '../../../attendance/presentation/widgets/attendance_time_label.dart';
import '../../domain/entities/attendance_feature_status.dart';

class AttendanceFeatureActiveBanner extends StatelessWidget {
  final AttendanceFeatureStatus feature;

  const AttendanceFeatureActiveBanner({super.key, required this.feature});

  String? _details() {
    final end = feature.endDate;
    final left = feature.daysLeft;
    final parts = [
      if (end != null)
        S().attendanceFeatureActiveUntil(AttendanceTimeLabel.date(end)),
      if (left != null) S().attendanceFeatureDaysLeft(left),
    ];
    return parts.isEmpty ? null : parts.join(' • ');
  }

  @override
  Widget build(BuildContext context) {
    final details = _details();
    if (!feature.owner || details == null) return const SizedBox.shrink();

    final scheme = context.colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: AppCard(
        padding: EdgeInsets.all(14.r),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    feature.autoRenew ? S().autoChargeOn : S().autoChargeOff,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (feature.isEndingSoon)
              StatusBadge(
                label: S().attendanceFeatureEndingSoon,
                tone: BadgeTone.danger,
              ),
          ],
        ),
      ),
    );
  }
}
