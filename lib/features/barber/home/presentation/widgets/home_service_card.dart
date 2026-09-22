import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class HomeServiceCard extends StatelessWidget {
  final bool enabled;
  final int pendingCount;
  final VoidCallback onTap;

  const HomeServiceCard({
    super.key,
    required this.enabled,
    this.pendingCount = 0,
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
            Icons.home_repair_service_outlined,
            size: 22.r,
            color: enabled ? context.semantic.accentStrong : scheme.onSurfaceVariant,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S().homeServiceOffered,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  pendingCount > 0
                      ? S().homeServicePendingCount(pendingCount)
                      : enabled
                          ? S().homeServiceCardEnabledHint
                          : S().homeServiceCardDisabledHint,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: pendingCount > 0
                        ? context.semantic.warning
                        : scheme.onSurfaceVariant,
                    fontWeight: pendingCount > 0 ? FontWeight.w600 : null,
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
