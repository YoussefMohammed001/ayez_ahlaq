import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../domain/entities/shop.dart';
import 'shop_avatar.dart';

class ShopDetailHeaderCard extends StatelessWidget {
  final Shop shop;
  final bool favorite;
  final VoidCallback onToggleFavorite;

  const ShopDetailHeaderCard({
    super.key,
    required this.shop,
    required this.favorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final hasAddress = shop.address != null && shop.address!.isNotEmpty;

    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShopAvatar(
            shopId: shop.id,
            shopName: shop.name,
            hasProfileImage: shop.hasProfileImage,
            size: 56.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 16.r,
                      color: context.semantic.accentSoft,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${shop.rating.toStringAsFixed(1)} (${shop.ratingCount})',
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                if (hasAddress) ...[
                  SizedBox(height: 6.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.place_outlined,
                        size: 16.r,
                        color: scheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          shop.address!,
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              favorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: favorite
                  ? context.semantic.warning
                  : scheme.onSurfaceVariant,
            ),
            onPressed: onToggleFavorite,
          ),
        ],
      ),
    );
  }
}
