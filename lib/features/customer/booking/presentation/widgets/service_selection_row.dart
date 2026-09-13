import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../shops/domain/entities/shop_barber.dart';

class ServiceSelectionRow extends StatelessWidget {
  final ShopBarberService service;
  final bool selected;
  final VoidCallback onTap;

  const ServiceSelectionRow({
    super.key,
    required this.service,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, top: service.popular ? 10.h : 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AppCard(
            onTap: onTap,
            borderColor: selected ? context.semantic.accentStrong : null,
            child: Row(
              children: [
                Icon(
                  selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                  size: 22.r,
                  color: selected ? context.semantic.accentStrong : scheme.onSurfaceVariant,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                      ),
                      if ((service.description ?? '').isNotEmpty) ...[
                        SizedBox(height: 3.h),
                        Text(
                          service.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
                        ),
                      ],
                      SizedBox(height: 4.h),
                      Text(
                        '${service.durationMinutes} ${S().minutesUnit}',
                        style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                Text(
                  S().currencyEgp(service.price),
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    color: context.semantic.accentStrong,
                  ),
                ),
              ],
            ),
          ),
          if (service.popular)
            Positioned(
              top: -10.h,
              right: 14.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: context.semantic.accentStrong,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Text(
                  S().servicePopularLabel,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.surfaceContainerLowest,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
