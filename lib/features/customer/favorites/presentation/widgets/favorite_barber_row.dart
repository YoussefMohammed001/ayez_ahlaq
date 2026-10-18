import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/relative_date_label.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../shops/presentation/widgets/shop_avatar.dart';
import '../../domain/entities/favorite_barber.dart';

class FavoriteBarberRow extends StatelessWidget {
  final FavoriteBarber favorite;
  final bool isRemoving;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final VoidCallback? onShopTap;

  const FavoriteBarberRow({
    super.key,
    required this.favorite,
    required this.isRemoving,
    required this.onTap,
    required this.onRemove,
    this.onShopTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          ShopAvatar(
            shopId: favorite.shopId,
            shopName: favorite.barberName,
            size: 48.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favorite.barberName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
                ),
                SizedBox(height: 3.h),
                Text(
                  favorite.shopName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.star_rounded, size: 15.r, color: context.semantic.accentSoft),
                    SizedBox(width: 3.w),
                    Text(
                      '${favorite.rating.toStringAsFixed(1)} (${favorite.ratingCount})',
                      style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
                    ),
                    if (favorite.since != null) ...[
                      SizedBox(width: 10.w),
                      Text(
                        RelativeDateLabel.format(favorite.since),
                        style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ],
                ),
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
          isRemoving
              ? SizedBox(
                  width: 20.r,
                  height: 20.r,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                )
              : InkWell(
                  onTap: onRemove,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Icon(Icons.favorite_rounded, size: 20.r, color: context.semantic.warning),
                  ),
                ),
        ],
      ),
    );
  }
}
