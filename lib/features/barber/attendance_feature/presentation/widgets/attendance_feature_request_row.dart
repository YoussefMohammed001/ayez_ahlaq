import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../generated/l10n.dart';
import '../../../attendance/presentation/widgets/attendance_time_label.dart';
import '../../domain/entities/attendance_feature_request.dart';
import '../../domain/entities/attendance_feature_request_status.dart';
import 'attendance_feature_price_label.dart';

class AttendanceFeatureRequestRow extends StatelessWidget {
  final AttendanceFeatureRequest request;

  const AttendanceFeatureRequestRow({super.key, required this.request});

  String get _statusLabel => switch (request.status) {
    AttendanceFeatureRequestStatus.pending => S().requestStatusPending,
    AttendanceFeatureRequestStatus.approved => S().requestStatusApproved,
    AttendanceFeatureRequestStatus.rejected => S().requestStatusRejected,
    AttendanceFeatureRequestStatus.cancelled =>
      S().walletRequestStatusCancelled,
    AttendanceFeatureRequestStatus.unknown => S().planStatusUnknown,
  };

  BadgeTone get _tone => switch (request.status) {
    AttendanceFeatureRequestStatus.pending => BadgeTone.gold,
    AttendanceFeatureRequestStatus.approved => BadgeTone.open,
    AttendanceFeatureRequestStatus.rejected => BadgeTone.danger,
    _ => BadgeTone.muted,
  };

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final style = TextStyle(fontSize: 12.5.sp, color: scheme.onSurfaceVariant);
    final createdAt = request.createdAt;
    final decidedAt = request.decidedAt;
    final price = request.price;
    final note = request.note;

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
                  createdAt == null ? '' : AttendanceTimeLabel.date(createdAt),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              StatusBadge(label: _statusLabel, tone: _tone),
            ],
          ),
          if (price != null && price > 0) ...[
            SizedBox(height: 6.h),
            Text(
              S().attendanceFeaturePrice(AttendanceFeaturePriceLabel.of(price)),
              style: style,
            ),
          ],
          if (decidedAt != null) ...[
            SizedBox(height: 4.h),
            Text(
              S().attendanceFeatureDecidedAt(
                AttendanceTimeLabel.date(decidedAt),
              ),
              style: style,
            ),
          ],
          if (note != null) ...[
            SizedBox(height: 4.h),
            Text(note, style: style),
          ],
        ],
      ),
    );
  }
}
