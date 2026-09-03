import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class ReviewsSummaryCard extends StatelessWidget {
  final double average;
  final int count;

  const ReviewsSummaryCard({super.key, required this.average, required this.count});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
      child: Row(
        children: [
          Icon(Icons.star_rounded, size: 32.r, color: context.semantic.accentStrong),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                average.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                S().reviewsCount(count),
                style: TextStyle(fontSize: 11.5.sp, color: context.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
