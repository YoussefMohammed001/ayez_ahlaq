import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/discount_percent_badge.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../shared/widgets/quantity_stepper.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_product.dart';
import 'store_product_thumbnail.dart';

class StoreProductCard extends StatelessWidget {
  final int shopId;
  final StoreProduct product;
  final int quantity;
  final bool isUpdating;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback? onTap;

  const StoreProductCard({
    super.key,
    required this.shopId,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
    this.isUpdating = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    StoreProductThumbnail(shopId: shopId, product: product, size: double.infinity),
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
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
                ),
                SizedBox(height: 4.h),
                if (product.isOutOfStock)
                  Text(
                    S().outOfStock,
                    style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w700, color: context.semantic.warning),
                  )
                else
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
                if (!product.isOutOfStock)
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
