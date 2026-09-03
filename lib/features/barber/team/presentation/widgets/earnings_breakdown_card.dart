import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/earnings.dart';

class EarningsBreakdownCard extends StatelessWidget {
  final Earnings earnings;

  const EarningsBreakdownCard({super.key, required this.earnings});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
      child: Column(
        children: [
          InfoRow(
            icon: Icons.receipt_long_outlined,
            label: S().avgTicketLabel,
            value: '${earnings.avgTicket}',
          ),
          InfoRow(
            icon: Icons.groups_outlined,
            label: S().clientsThisMonthLabel,
            value: '${earnings.clientsThisMonth}',
          ),
          InfoRow(
            icon: Icons.shopping_bag_outlined,
            label: S().supplierSpendLabel,
            value: '${earnings.supplierSpendThisMonth}',
          ),
          InfoRow(
            icon: Icons.account_balance_wallet_outlined,
            label: S().netThisMonthLabel,
            value: '${earnings.netThisMonth}',
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
