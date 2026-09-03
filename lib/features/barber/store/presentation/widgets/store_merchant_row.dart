import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_merchant.dart';

class StoreMerchantRow extends StatelessWidget {
  final StoreMerchant merchant;
  final VoidCallback onTap;

  const StoreMerchantRow({super.key, required this.merchant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          AvatarCircle(
            initials: merchant.businessName.isEmpty
                ? S().avatarFallback
                : merchant.businessName.substring(0, 1),
            size: 48.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  merchant.businessName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.star_rounded, size: 15.r, color: context.semantic.accentSoft),
                    SizedBox(width: 3.w),
                    Text(
                      '${merchant.rating.toStringAsFixed(1)} (${merchant.ratingCount})',
                      style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      S().productsCount,
                      style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
                    ),
                    Text(
                      ' ${merchant.productCount}',
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
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
