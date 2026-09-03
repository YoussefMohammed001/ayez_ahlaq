import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/app_card.dart';
import '../../../../../../core/widgets/badge_tone.dart';
import '../../../../../../core/widgets/status_badge.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_category.dart';
import 'storefront_category_thumbnail.dart';

class StorefrontCategoryRow extends StatelessWidget {
  final StorefrontCategory category;
  final VoidCallback? onRemove;

  const StorefrontCategoryRow({super.key, required this.category, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          StorefrontCategoryThumbnail(size: 42.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
                color: context.colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          StatusBadge(
            label: category.global ? S().categoryGlobal : S().categoryOwn,
            tone: category.global ? BadgeTone.muted : BadgeTone.gold,
            showDot: false,
          ),
          if (onRemove != null) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onRemove,
              child: Icon(
                Icons.delete_outline,
                size: 18.r,
                color: context.semantic.warning,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
