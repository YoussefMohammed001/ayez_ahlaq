import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/stat_tile.dart';
import '../../../../../generated/l10n.dart';
import '../../../team/domain/entities/earnings.dart';

class HomeEarningsGrid extends StatelessWidget {
  final Earnings earnings;
  final VoidCallback onTap;

  const HomeEarningsGrid({super.key, required this.earnings, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatTile(
            value: S().currencyEgp(earnings.today),
            label: S().earningsToday,
            onTap: onTap,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatTile(
            value: '${earnings.clientsToday}',
            label: S().tabBookings,
            onTap: onTap,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatTile(
            value: S().currencyEgp(earnings.thisMonth),
            label: S().earningsThisMonth,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
