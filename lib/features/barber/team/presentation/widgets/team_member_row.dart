import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/team_member.dart';

class TeamMemberRow extends StatelessWidget {
  final TeamMember member;
  final VoidCallback? onTap;

  const TeamMemberRow({super.key, required this.member, this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

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
                Text(
                  member.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${S().clientsThisMonthLabel}: ${member.clientsThisMonth} · ${S().ratingLabel} ${member.rating.toStringAsFixed(1)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10.5.sp, color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            S().rankLabel(member.rank),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w800,
              color: context.semantic.accentSoft,
            ),
          ),
        ],
      ),
    );
  }
}
