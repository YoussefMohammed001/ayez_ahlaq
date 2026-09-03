import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../core/widgets/toggle_switch.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/team_member_detail.dart';

class MemberInfoCard extends StatelessWidget {
  final TeamMemberDetail member;
  final ValueChanged<bool> onAvailabilityChanged;

  const MemberInfoCard({
    super.key,
    required this.member,
    required this.onAvailabilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
      child: Column(
        children: [
          InfoRow(
            icon: Icons.call_outlined,
            label: S().memberPhoneLabel,
            value: member.phoneNumber,
          ),
          if (member.tagline.isNotEmpty)
            InfoRow(
              icon: Icons.notes_outlined,
              label: S().memberTaglineLabel,
              value: member.tagline,
            ),
          InfoRow(
            icon: Icons.star_border_rounded,
            label: S().ratingLabel,
            value:
                '${member.rating.toStringAsFixed(1)} (${member.ratingCount})',
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    S().availabilityLabel,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                ToggleSwitch(
                  value: member.available,
                  onTap: () => onAvailabilityChanged(!member.available),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: StatusBadge(
                label: member.active ? S().activeLabel : S().blockedLabel,
                tone: member.active ? BadgeTone.open : BadgeTone.danger,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
