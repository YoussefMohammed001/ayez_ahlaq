import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../domain/entities/discount.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DiscountCard extends StatelessWidget {
  final Discount discount;
  final VoidCallback? onClose;
  final VoidCallback? onTap;

  const DiscountCard({
    super.key,
    required this.discount,
    this.onClose,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: discount.liveNow ? 1 : 0.55,
      child: AppCard(
        onTap: onTap,
        margin: EdgeInsets.only(bottom: 10.h),
        borderColor: discount.liveNow
            ? context.colorScheme.primary
            : context.colorScheme.outline,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    discount.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.5.sp,
                      color: context.colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                StatusBadge(
                  label: discount.liveNow ? S().discountLive : S().discountClosed,
                  tone: discount.liveNow ? BadgeTone.open : BadgeTone.muted,
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              discount.summary,
              style: TextStyle(
                fontSize: 11.5.sp,
                color: context.colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  Icons.storefront_outlined,
                  size: 13.r,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Text(
                    discount.isAllShops
                        ? S().allShops
                        : discount.shops.map((s) => s.name).join(S().listSeparator),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                if (discount.liveNow && onClose != null)
                  GestureDetector(
                    onTap: onClose,
                    child: Text(
                      S().closeAction,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: context.semantic.warning,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
