import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/shop.dart';
import 'shop_avatar.dart';

class ShopRow extends StatelessWidget {
  final Shop shop;
  final VoidCallback onTap;
  final VoidCallback? onShopTap;

  const ShopRow({
    super.key,
    required this.shop,
    required this.onTap,
    this.onShopTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 10.h),
      borderColor: shop.sponsored
          ? context.semantic.accentStrong
          : scheme.outline,
      child: Row(
        children: [
          ShopAvatar(
            shopId: shop.id,
            shopName: shop.name,
            hasProfileImage: shop.hasProfileImage,
            size: 48.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        shop.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                    if (shop.sponsored) ...[
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.star_rounded,
                        size: 18.r,
                        color: context.semantic.accentStrong,
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 15.r,
                      color: context.semantic.accentSoft,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      '${shop.rating.toStringAsFixed(1)} (${shop.ratingCount})',
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    if (shop.distanceKm != null) ...[
                      SizedBox(width: 10.w),
                      Icon(
                        Icons.place_outlined,
                        size: 14.r,
                        color: scheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '${shop.distanceKm!.toStringAsFixed(1)} ${S().kmUnit}',
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
                if (shop.address != null && shop.address!.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    shop.address!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onShopTap != null)
            InkWell(
              onTap: onShopTap,
              borderRadius: BorderRadius.circular(8.r),
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Icon(
                  Icons.storefront_outlined,
                  size: 20.r,
                  color: context.semantic.accentSoft,
                ),
              ),
            ),
          Icon(Icons.chevron_right, size: 20.r, color: scheme.onSurfaceVariant),
        ],
      ),
    );
  }
}
