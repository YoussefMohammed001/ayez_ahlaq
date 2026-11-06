import 'package:flutter/material.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/auto_attendance_policy.dart';
import '../../domain/entities/enable_auto_attendance_result.dart';
import '../manager/auto_attendance_cubit.dart';

class AutoAttendanceResultHandler {
  const AutoAttendanceResultHandler._();

  static Future<void> handle(
    BuildContext context,
    EnableAutoAttendanceResult result,
    AutoAttendanceCubit cubit,
  ) async {
    switch (result) {
      case EnableAutoAttendanceResult.enabled:
        return;
      case EnableAutoAttendanceResult.noShopLocation:
        showWarning(S().autoAttendanceNoShopLocation);
      case EnableAutoAttendanceResult.rangeTooSmall:
        showWarning(
          S().autoAttendanceRangeTooSmall(
            AutoAttendancePolicy.minEnforcedRangeMeters.ceil(),
          ),
        );
      case EnableAutoAttendanceResult.permissionDenied:
        showWarning(S().autoAttendancePermissionDenied);
      case EnableAutoAttendanceResult.failed:
        showError(S().autoAttendanceFailed);
      case EnableAutoAttendanceResult.needsAlwaysPermission:
        await _offerSettings(context, S().autoAttendanceNeedsAlways, cubit);
      case EnableAutoAttendanceResult.permissionBlocked:
        await _offerSettings(context, S().autoAttendanceBlocked, cubit);
    }
  }

  static Future<void> _offerSettings(
    BuildContext context,
    String message,
    AutoAttendanceCubit cubit,
  ) async {
    final open = await showConfirmDialog(
      context,
      title: S().autoAttendanceDialogTitle,
      message: message,
      confirmLabel: S().autoAttendanceOpenSettings,
      icon: Icons.location_on_outlined,
      isDestructive: false,
    );
    if (open) await cubit.openSettings();
  }
}
