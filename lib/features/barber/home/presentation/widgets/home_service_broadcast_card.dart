import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class HomeServiceBroadcastCard extends StatelessWidget {
  final int pendingCount;
  final VoidCallback onTap;

  const HomeServiceBroadcastCard({
    super.key,
    required this.pendingCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.campaign_outlined,
            size: 22.r,
            color: context.semantic.warning,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S().homeServiceBroadcastInboxTitle,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  S().homeServiceBroadcastPendingCount(pendingCount),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: context.semantic.warning,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: scheme.onSurfaceVariant, size: 20.r),
        ],
      ),
    );
  }
}
