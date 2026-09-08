import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class HomeStorefrontOrdersCard extends StatelessWidget {
  final int pendingCount;
  final VoidCallback onTap;

  const HomeStorefrontOrdersCard({
    super.key,
    required this.pendingCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (pendingCount == 0) return const SizedBox.shrink();

    final scheme = context.colorScheme;
    final warning = context.semantic.warning;

    return AppCard(
      onTap: onTap,
      borderColor: warning,
      child: Row(
        children: [
          Container(
            width: 8.r,
            height: 8.r,
            decoration: BoxDecoration(color: warning, shape: BoxShape.circle),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              S().newStorefrontOrdersCount(pendingCount),
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: scheme.onSurfaceVariant, size: 20.r),
        ],
      ),
    );
  }
}
