import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/badge_tone.dart';
import '../../../../../../core/widgets/status_badge.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_category.dart';
import 'storefront_category_thumbnail.dart';

class StorefrontCategoryOptionTile extends StatelessWidget {
  final StorefrontCategory category;
  final bool selected;
  final VoidCallback onTap;

  const StorefrontCategoryOptionTile({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: selected ? scheme.primary : scheme.outline),
        ),
        child: Row(
          children: [
            StorefrontCategoryThumbnail(size: 48.r),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                category.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            StatusBadge(
              label: category.global ? S().categoryGlobal : S().categoryOwn,
              tone: category.global ? BadgeTone.muted : BadgeTone.gold,
              showDot: false,
            ),
            SizedBox(width: 8.w),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 20.r,
              color: selected ? scheme.primary : scheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
