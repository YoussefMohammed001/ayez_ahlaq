import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/merchant_member.dart';

class MerchantMemberRow extends StatelessWidget {
  final MerchantMember member;
  final VoidCallback onTap;

  const MerchantMemberRow({
    super.key,
    required this.member,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          AvatarCircle(
            initials: member.name.isEmpty ? '' : member.name.substring(0, 1),
            size: 44.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  member.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: font14w700.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                AppText(
                  member.phoneNumber,
                  style: font11w500.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (!member.active)
            StatusBadge(label: S().blockedLabel, tone: BadgeTone.danger),
        ],
      ),
    );
  }
}
