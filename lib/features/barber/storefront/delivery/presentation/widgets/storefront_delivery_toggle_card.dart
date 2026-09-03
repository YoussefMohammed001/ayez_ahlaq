import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/app_card.dart';
import '../../../../../../core/widgets/toggle_switch.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';

class StorefrontDeliveryToggleCard extends StatelessWidget {
  final bool offered;
  final ValueChanged<bool> onChanged;

  const StorefrontDeliveryToggleCard({
    super.key,
    required this.offered,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Icon(
            Icons.delivery_dining_outlined,
            size: 22.r,
            color: offered
                ? context.semantic.accentStrong
                : context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S().deliveryOffered,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                if (!offered) ...[
                  SizedBox(height: 3.h),
                  Text(
                    S().deliveryOffLabel,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          ToggleSwitch(value: offered, onTap: () => onChanged(!offered)),
        ],
      ),
    );
  }
}
