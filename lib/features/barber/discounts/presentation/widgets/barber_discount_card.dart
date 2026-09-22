import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../domain/entities/barber_discount.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class BarberDiscountCard extends StatelessWidget {
  final BarberDiscount discount;
  final VoidCallback? onClose;
  final VoidCallback? onTap;

  const BarberDiscountCard({
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
            if (discount.liveNow && onClose != null) ...[
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
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
              ),
            ],
          ],
        ),
      ),
    );
  }
}
