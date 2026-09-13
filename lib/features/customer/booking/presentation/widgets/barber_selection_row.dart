import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../shops/domain/entities/shop_barber.dart';
import 'barber_status_badge.dart';

class BarberSelectionRow extends StatelessWidget {
  final ShopBarber barber;
  final VoidCallback onTap;

  const BarberSelectionRow({super.key, required this.barber, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barber.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                if ((barber.tagline ?? '').isNotEmpty) ...[
                  SizedBox(height: 3.h),
                  Text(
                    barber.tagline!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
                  ),
                ],
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      barber.rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    ...List.generate(
                      5,
                      (i) => Icon(
                        i < barber.rating.round() ? Icons.star_rounded : Icons.star_border_rounded,
                        size: 13.r,
                        color: context.semantic.accentStrong,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                BarberStatusBadge(available: barber.available),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          AvatarCircle(
            initials: barber.name.isEmpty ? S().avatarFallback : barber.name.substring(0, 1),
            size: 52.r,
          ),
        ],
      ),
    );
  }
}
