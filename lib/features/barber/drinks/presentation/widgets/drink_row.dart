import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/drink.dart';

class DrinkRow extends StatelessWidget {
  final Drink drink;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  const DrinkRow({
    super.key,
    required this.drink,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 10.h),
      onTap: onEdit,
      child: Row(
        children: [
          Icon(
            Icons.local_cafe_outlined,
            size: 22.r,
            color: context.colorScheme.primary,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  drink.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: font13w700.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  S().currencyEgp(drink.price),
                  style: font12w400.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (!drink.active)
            StatusBadge(
              label: S().drinkInactive,
              tone: BadgeTone.muted,
              showDot: false,
            ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.delete_outline,
              size: 18.r,
              color: context.semantic.warning,
            ),
          ),
        ],
      ),
    );
  }
}
