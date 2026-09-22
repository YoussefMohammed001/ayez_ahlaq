import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/home_service_shop.dart';

class HomeServiceShopRow extends StatelessWidget {
  final HomeServiceShop shop;
  final VoidCallback onTap;

  const HomeServiceShopRow({super.key, required this.shop, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          AvatarCircle(
            initials: shop.name.isEmpty ? S().avatarFallback : shop.name.substring(0, 1),
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
                    if (shop.sponsored)
                      StatusBadge(
                        label: S().sponsoredLabel,
                        tone: BadgeTone.gold,
                        showDot: false,
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.star_rounded, size: 15.r, color: context.semantic.accentSoft),
                    SizedBox(width: 3.w),
                    Text(
                      '${shop.rating.toStringAsFixed(1)} (${shop.ratingCount})',
                      style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
                    ),
                    if (shop.distanceKm != null) ...[
                      SizedBox(width: 10.w),
                      Icon(Icons.place_outlined, size: 14.r, color: scheme.onSurfaceVariant),
                      SizedBox(width: 2.w),
                      Text(
                        '${shop.distanceKm!.toStringAsFixed(1)} ${S().kmUnit}',
                        style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  S().homeServiceStartingPrice(shop.homeServicePrice.toString()),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: context.semantic.accentStrong,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, size: 20.r, color: scheme.onSurfaceVariant),
        ],
      ),
    );
  }
}
