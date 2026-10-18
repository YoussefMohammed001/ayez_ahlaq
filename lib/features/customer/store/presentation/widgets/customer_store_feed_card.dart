import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/discount_percent_badge.dart';
import '../../../../../core/widgets/network_image_with_app_icon_fallback.dart';
import '../../../../../core/widgets/store_entity_chip.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_feed_product.dart';

class CustomerStoreFeedCard extends StatelessWidget {
  final StoreFeedProduct item;
  final VoidCallback onTap;

  const CustomerStoreFeedCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final product = item.product;

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
                    NetworkImageWithAppIconFallback(
                      endPoint: EndPoints.customerShopStorefrontProductImage(
                        item.shopId,
                        product.id,
                      ),
                      hasImage: product.hasImage,
                      width: double.infinity,
                      height: double.infinity,
                      borderRadius: BorderRadius.zero,
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
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                StoreEntityChip(name: item.shopName),
                SizedBox(height: 4.h),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
