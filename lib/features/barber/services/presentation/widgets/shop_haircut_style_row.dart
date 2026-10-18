import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/toggle_switch.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/shop_haircut_style.dart';

class ShopHaircutStyleRow extends StatelessWidget {
  final ShopHaircutStyle style;
  final ValueChanged<bool> onToggleActive;
  final VoidCallback onEditPrice;

  const ShopHaircutStyleRow({
    super.key,
    required this.style,
    required this.onToggleActive,
    required this.onEditPrice,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      onTap: onEditPrice,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  style.priceDelta == 0
                      ? S().haircutStyleNotPricedYet
                      : S().haircutStylePriceDeltaLine(style.priceDelta),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10.5.sp, color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Icon(
              Icons.edit_outlined,
              size: 18.r,
              color: scheme.onSurfaceVariant,
            ),
          ),
          ToggleSwitch(value: style.active, onTap: () => onToggleActive(!style.active)),
        ],
      ),
    );
  }
}
