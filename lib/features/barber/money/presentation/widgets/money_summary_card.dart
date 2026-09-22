import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/stat_tile.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/money_summary.dart';

class MoneySummaryCard extends StatelessWidget {
  final MoneySummary summary;

  const MoneySummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatTile(
            value: summary.totalAdded.toString(),
            label: S().moneyTotalAdded,
            valueColor: Colors.green,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatTile(
            value: summary.totalSubtracted.toString(),
            label: S().moneyTotalSubtracted,
            valueColor: Colors.redAccent,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatTile(value: summary.net.toString(), label: S().moneyNet),
        ),
      ],
    );
  }
}
