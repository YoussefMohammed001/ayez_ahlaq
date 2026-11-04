import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../generated/l10n.dart';
import '../../../attendance/presentation/widgets/attendance_time_label.dart';
import '../../domain/entities/attendance_feature_request.dart';
import '../manager/attendance_feature_request_cubit.dart';

class AttendanceFeaturePendingCard extends StatelessWidget {
  final AttendanceFeatureRequest? request;
  final VoidCallback onChanged;

  const AttendanceFeaturePendingCard({
    super.key,
    required this.request,
    required this.onChanged,
  });

  Future<void> _cancel(BuildContext context) async {
    final cubit = context.read<AttendanceFeatureRequestCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: S().attendanceFeatureCancelConfirmTitle,
      message: S().attendanceFeatureCancelConfirmMessage,
      confirmLabel: S().attendanceFeatureCancelAction,
      cancelLabel: S().back,
      icon: Icons.close_rounded,
    );
    if (!confirmed) return;

    final done = await cubit.cancelRequest(request?.id);
    if (!done) return;

    showSuccess(S().attendanceFeatureCancelled);
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final createdAt = request?.createdAt;

    return AppCard(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  S().attendanceFeaturePendingTitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              StatusBadge(
                label: S().requestStatusPending,
                tone: BadgeTone.gold,
              ),
            ],
          ),
          if (createdAt != null) ...[
            SizedBox(height: 6.h),
            Text(
              S().attendanceFeaturePendingSince(
                AttendanceTimeLabel.date(createdAt),
              ),
              style: TextStyle(fontSize: 12.sp, color: scheme.onSurfaceVariant),
            ),
          ],
          if (request?.id != null) ...[
            SizedBox(height: 10.h),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton.icon(
                onPressed: () => _cancel(context),
                icon: Icon(Icons.close_rounded, size: 16.r),
                label: Text(S().attendanceFeatureCancelAction),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
