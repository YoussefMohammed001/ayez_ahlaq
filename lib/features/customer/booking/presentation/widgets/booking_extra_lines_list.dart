import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../generated/l10n.dart';
import 'booking_extra_line.dart';

class BookingExtraLinesList extends StatelessWidget {
  final List<BookingExtraLine> lines;

  const BookingExtraLinesList({super.key, required this.lines});

  @override
  Widget build(BuildContext context) {
    if (lines.isEmpty) return const SizedBox.shrink();

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
        for (final line in lines)
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Row(
              children: [
                Icon(
                  line.isDrink
                      ? Icons.local_cafe_outlined
                      : Icons.shopping_bag_outlined,
                  size: 14.r,
                  color: scheme.onSurfaceVariant,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    '${line.name ?? ''} × ${line.quantity}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: font12w400.copyWith(color: scheme.onSurface),
                  ),
                ),
                if (line.lineTotal != null)
                  Text(
                    S().currencyEgp(line.lineTotal!),
                    style: font12w400.copyWith(color: scheme.onSurfaceVariant),
                  )
                else if (line.price != null)
                  Text(
                    S().currencyEgp(line.price! * line.quantity),
                    style: font12w400.copyWith(color: scheme.onSurfaceVariant),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
