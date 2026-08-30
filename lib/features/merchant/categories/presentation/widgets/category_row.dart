import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../domain/entities/merchant_category.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class CategoryRow extends StatelessWidget {
  final MerchantCategory category;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const CategoryRow({
    super.key,
    required this.category,
    this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Container(
            width: 42.r,
            height: 42.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.category_outlined,
              size: 20.r,
              color: context.semantic.accentSoft,
            ),
          ),
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
