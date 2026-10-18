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
            value: S().currencyEgp(earnings.avgTicket),
          ),
          InfoRow(
            icon: Icons.groups_outlined,
            label: S().clientsThisMonthLabel,
            value: '${earnings.clientsThisMonth}',
          ),
          InfoRow(
            icon: Icons.groups_outlined,
            label: S().clientsLast7DaysLabel,
            value: '${earnings.clientsLast7Days}',
          ),
          InfoRow(
            icon: Icons.local_cafe_outlined,
            label: S().productsThisMonthLabel,
            value: S().currencyEgp(earnings.productsThisMonth),
          ),
          InfoRow(
            icon: Icons.shopping_cart_outlined,
            label: S().productOrdersThisMonthLabel,
            value: '${earnings.productOrdersThisMonth}',
          ),
          InfoRow(
            icon: Icons.summarize_outlined,
            label: S().totalThisMonthLabel,
            value: S().currencyEgp(earnings.totalThisMonth),
          ),
          InfoRow(
            icon: Icons.shopping_bag_outlined,
            label: S().supplierSpendLabel,
            value: S().currencyEgp(earnings.supplierSpendThisMonth),
          ),
          if (earnings.tillAddedThisMonth != 0)
            InfoRow(
              icon: Icons.add_card_outlined,
              label: S().tillAddedLabel,
              value: S().currencyEgp(earnings.tillAddedThisMonth),
            ),
          if (earnings.tillSubtractedThisMonth != 0)
            InfoRow(
              icon: Icons.remove_circle_outline,
              label: S().tillSubtractedLabel,
              value: S().currencyEgp(earnings.tillSubtractedThisMonth),
            ),
          InfoRow(
            icon: Icons.account_balance_wallet_outlined,
            label: S().netThisMonthLabel,
            value: S().currencyEgp(earnings.netThisMonth),
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
