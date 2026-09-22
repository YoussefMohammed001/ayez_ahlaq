import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../booking/presentation/widgets/barber_status_badge.dart';
import '../../domain/entities/shop_barber.dart';

class ShopBarberRow extends StatelessWidget {
  final ShopBarber barber;
  final bool showDivider;

  const ShopBarberRow({
    super.key,
    required this.barber,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: showDivider ? scheme.outline : Colors.transparent),
        ),
      ),
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
                Text(
                  barber.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.5.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
                ),
                if ((barber.tagline ?? '').isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    barber.tagline!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
                  ),
                ],
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.star_rounded, size: 14.r, color: context.semantic.accentSoft),
                    SizedBox(width: 3.w),
                    Text(
                      '${barber.rating.toStringAsFixed(1)} (${barber.ratingCount})',
                      style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
                    ),
                    SizedBox(width: 8.w),
                    BarberStatusBadge(available: barber.available),
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
