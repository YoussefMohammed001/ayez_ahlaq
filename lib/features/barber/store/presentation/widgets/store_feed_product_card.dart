import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/discount_percent_badge.dart';
import '../../../../../core/widgets/network_image_with_app_icon_fallback.dart';
import '../../../../../core/widgets/store_entity_chip.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/quantity_stepper.dart';
import '../../domain/entities/store_feed_product.dart';

class StoreFeedProductCard extends StatelessWidget {
  final StoreFeedProduct product;
  final int quantity;
  final bool isUpdating;
  final VoidCallback onTap;
  final VoidCallback onMerchantTap;
  final ValueChanged<int> onQuantityChanged;

  const StoreFeedProductCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.onTap,
    required this.onMerchantTap,
    required this.onQuantityChanged,
    this.isUpdating = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  NetworkImageWithAppIconFallback(
                    endPoint: EndPoints.barberStoreProductImage(product.id),
                    hasImage: product.hasImage,
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: BorderRadius.zero,
                  ),
                  if (product.isSponsored)
                    PositionedDirectional(
                      top: 6.h,
                      start: 6.w,
                      child: _Badge(label: S().sponsoredLabel, color: context.semantic.accentSoft),
                    ),
                  if (product.isDiscounted)
                    PositionedDirectional(
                      top: 6.h,
                      end: 6.w,
                      child: DiscountPercentBadge(percent: product.discountPercent),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                StoreEntityChip(name: product.merchantName, onTap: onMerchantTap),
                SizedBox(height: 4.h),
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      S().currencyEgp(product.effectivePrice),
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w800, color: context.semantic.accentSoft),
                    ),
                    if (product.isDiscounted) ...[
                      SizedBox(width: 6.w),
                      Text(
                        S().currencyEgp(product.price),
                        style: TextStyle(
                          fontSize: 10.5.sp,
                          color: scheme.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 6.h),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: QuantityStepper(
                    quantity: quantity,
                    minQuantity: product.minOrderQty,
                    onChanged: onQuantityChanged,
                    disabled: isUpdating,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;

  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(100.r)),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9.5.sp,
          fontWeight: FontWeight.w700,
          color: context.colorScheme.surfaceContainerLowest,
        ),
      ),
    );
  }
}
