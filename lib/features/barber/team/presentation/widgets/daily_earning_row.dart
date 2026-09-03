import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/daily_earning.dart';

class DailyEarningRow extends StatelessWidget {
  final DailyEarning day;

  const DailyEarningRow({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      margin: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              day.date,
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
          ),
          Text(
            S().earningsClientsLine(day.clients),
            style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
          ),
          SizedBox(width: 10.w),
          Text(
            '${day.amount}',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: context.semantic.accentSoft,
            ),
          ),
        ],
      ),
    );
  }
}
