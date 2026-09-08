import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/booking_addon.dart';

class BookingExtrasSummary extends StatelessWidget {
  final List<BookingAddon> addons;

  const BookingExtrasSummary({super.key, required this.addons});

  @override
  Widget build(BuildContext context) {
    if (addons.isEmpty) return const SizedBox.shrink();

    final scheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text(
          S().billAdjustments,
          style: font12w600.copyWith(color: scheme.onSurfaceVariant),
        ),
        SizedBox(height: 6.h),
        for (final addon in addons)
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Row(
              children: [
                Icon(
                  addon.isDrink
                      ? Icons.local_cafe_outlined
                      : Icons.shopping_bag_outlined,
                  size: 14.r,
                  color: scheme.onSurfaceVariant,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    '${addon.name ?? ''} × ${addon.quantity}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: font12w400.copyWith(color: scheme.onSurface),
                  ),
                ),
                if (addon.price != null)
                  Text(
                    S().currencyEgp(addon.price! * addon.quantity),
                    style: font12w400.copyWith(color: scheme.onSurfaceVariant),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
