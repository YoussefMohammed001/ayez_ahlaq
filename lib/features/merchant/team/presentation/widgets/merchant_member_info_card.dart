import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/merchant_member.dart';

class MerchantMemberInfoCard extends StatelessWidget {
  final MerchantMember member;

  const MerchantMemberInfoCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final salary = member.salary;

    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
      child: Column(
        children: [
          InfoRow(
            icon: Icons.call_outlined,
            label: S().memberPhoneLabel,
            value: member.phoneNumber,
            valueTextDirection: TextDirection.ltr,
          ),
          InfoRow(
            icon: Icons.payments_outlined,
            label: S().salaryAmountRow,
            value: salary == null
                ? S().salaryNotSet
                : salary.toStringAsFixed(0),
            showDivider: false,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
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
