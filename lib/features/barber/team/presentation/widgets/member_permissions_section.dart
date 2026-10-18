import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../profile/domain/entities/barber_permissions.dart';
import 'member_permission_row.dart';

class MemberPermissionsSection extends StatelessWidget {
  final BarberPermissions permissions;
  final ValueChanged<BarberPermissions> onChanged;

  const MemberPermissionsSection({
    super.key,
    required this.permissions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().memberPermissionsTitle),
        AppCard(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
          child: Column(
            children: [
              MemberPermissionRow(
                title: S().permissionViewRevenue,
                hint: S().permissionViewRevenueHint,
                value: permissions.canViewRevenue,
                onTap: () => onChanged(
                  BarberPermissions(
                    canViewRevenue: !permissions.canViewRevenue,
                    canCloseBookings: permissions.canCloseBookings,
                    canMarkPaid: permissions.canMarkPaid,
                  ),
                ),
              ),
              MemberPermissionRow(
                title: S().permissionCloseBookings,
                hint: S().permissionCloseBookingsHint,
                value: permissions.canCloseBookings,
                onTap: () => onChanged(
                  BarberPermissions(
                    canViewRevenue: permissions.canViewRevenue,
                    canCloseBookings: !permissions.canCloseBookings,
                    canMarkPaid:
                        permissions.canCloseBookings ? false : permissions.canMarkPaid,
                  ),
                ),
              ),
              MemberPermissionRow(
                title: S().permissionMarkPaid,
                hint: permissions.canCloseBookings
                    ? S().permissionMarkPaidHint
                    : S().permissionMarkPaidNeedsClose,
                value: permissions.canMarkPaid,
                enabled: permissions.canCloseBookings,
                onTap: () => onChanged(
                  BarberPermissions(
                    canViewRevenue: permissions.canViewRevenue,
                    canCloseBookings: permissions.canCloseBookings,
                    canMarkPaid: !permissions.canMarkPaid,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
