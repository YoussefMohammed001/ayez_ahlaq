import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../barber/team/presentation/widgets/member_permission_row.dart';
import '../../domain/entities/merchant_member_permissions.dart';

class MerchantMemberPermissionsSection extends StatelessWidget {
  final MerchantMemberPermissions permissions;
  final ValueChanged<MerchantMemberPermissions> onChanged;

  const MerchantMemberPermissionsSection({
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
                title: S().memberPermissionManageProducts,
                hint: S().memberPermissionManageProductsHint,
                value: permissions.canManageProducts,
                onTap: () => onChanged(
                  permissions.copyWith(
                    canManageProducts: !permissions.canManageProducts,
                  ),
                ),
              ),
              MemberPermissionRow(
                title: S().memberPermissionSell,
                hint: S().memberPermissionSellHint,
                value: permissions.canSell,
                onTap: () => onChanged(
                  permissions.copyWith(canSell: !permissions.canSell),
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
