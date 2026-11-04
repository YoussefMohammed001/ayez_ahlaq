import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/attendance_feature_status.dart';
import 'attendance_feature_owner_panel.dart';

class AttendanceFeatureLockedView extends StatelessWidget {
  final AttendanceFeatureStatus feature;
  final VoidCallback onChanged;

  const AttendanceFeatureLockedView({
    super.key,
    required this.feature,
    required this.onChanged,
  });

  String get _message {
    if (feature.message.isNotEmpty) return feature.message;
    return feature.owner
        ? S().attendanceFeatureOwnerFallback
        : S().attendanceFeatureMemberFallback;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          padding: EdgeInsets.all(18.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: 28.r,
                color: scheme.primary,
              ),
              SizedBox(height: 12.h),
              Text(
                feature.isExpired
                    ? S().attendanceFeatureExpiredTitle
                    : S().attendanceFeatureLockedTitle,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                _message,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        if (feature.owner)
          AttendanceFeatureOwnerPanel(feature: feature, onChanged: onChanged),
      ],
    );
  }
}
