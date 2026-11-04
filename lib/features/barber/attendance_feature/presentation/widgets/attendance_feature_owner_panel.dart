import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../domain/entities/attendance_feature_status.dart';
import '../manager/attendance_feature_request_cubit.dart';
import '../manager/attendance_feature_request_state.dart';
import 'attendance_feature_pending_card.dart';
import 'attendance_feature_price_label.dart';

class AttendanceFeatureOwnerPanel extends StatelessWidget {
  final AttendanceFeatureStatus feature;
  final VoidCallback onChanged;

  const AttendanceFeatureOwnerPanel({
    super.key,
    required this.feature,
    required this.onChanged,
  });

  Future<void> _request(BuildContext context) async {
    final cubit = context.read<AttendanceFeatureRequestCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: S().attendanceFeatureRequestConfirmTitle,
      message: S().attendanceFeatureRequestConfirmMessage,
      confirmLabel: S().attendanceFeatureRequestAction,
      icon: Icons.send_rounded,
      isDestructive: false,
    );
    if (!confirmed) return;

    final done = await cubit.requestFeature();
    if (!done) return;

    showSuccess(S().attendanceFeatureRequested);
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<
      AttendanceFeatureRequestCubit,
      AttendanceFeatureRequestState
    >(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (feature.price > 0) ...[
            SizedBox(height: 14.h),
            Text(
              S().attendanceFeaturePrice(
                AttendanceFeaturePriceLabel.of(feature.price),
              ),
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurface,
              ),
            ),
          ],
          SizedBox(height: 16.h),
          if (feature.isPending)
            AttendanceFeaturePendingCard(
              request: feature.pendingRequest,
              onChanged: onChanged,
            )
          else if (feature.canRequest)
            PrimaryCtaButton(
              label: feature.isExpired
                  ? S().attendanceFeatureRenewAction
                  : S().attendanceFeatureRequestAction,
              onPressed: () => _request(context),
            ),
          SizedBox(height: 16.h),
          AppCard(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: MenuRow(
              icon: Icons.history_rounded,
              label: S().attendanceFeatureRequestsLink,
              showDivider: false,
              onTap: () =>
                  context.push(Routes.barberAttendanceFeatureRequestsScreen),
            ),
          ),
        ],
      ),
    );
  }
}
