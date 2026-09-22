import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/stat_tile.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/earnings.dart';

class EarningsSummaryGrid extends StatelessWidget {
  final Earnings earnings;

  const EarningsSummaryGrid({super.key, required this.earnings});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatTile(
            value: S().currencyEgp(earnings.today),
            label: S().earningsToday,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatTile(
            value: S().currencyEgp(earnings.last7Days),
            label: S().earningsLast7Days,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatTile(
            value: S().currencyEgp(earnings.thisMonth),
            label: S().earningsThisMonth,
          ),
        ),
      ],
    );
  }
}
