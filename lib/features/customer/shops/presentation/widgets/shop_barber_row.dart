import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/shop_barber.dart';

class ShopBarberRow extends StatelessWidget {
  final ShopBarber barber;
  final VoidCallback onToggleFavorite;

  const ShopBarberRow({super.key, required this.barber, required this.onToggleFavorite});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarCircle(
            initials: barber.name.isEmpty ? S().avatarFallback : barber.name.substring(0, 1),
            size: 44.r,
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
                        barber.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onToggleFavorite,
                      borderRadius: BorderRadius.circular(8.r),
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Icon(
                          barber.favorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          size: 18.r,
                          color: barber.favorite ? context.semantic.warning : scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.star_rounded, size: 14.r, color: context.semantic.accentSoft),
                    SizedBox(width: 3.w),
                    Text(
                      '${barber.rating.toStringAsFixed(1)} (${barber.ratingCount})',
                      style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
                if (barber.services.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 6.w,
                    runSpacing: 6.h,
                    children: barber.services
                        .map(
                          (service) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: scheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              '${service.name} · ${service.price}',
                              style: TextStyle(fontSize: 10.5.sp, color: scheme.onSurfaceVariant),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
