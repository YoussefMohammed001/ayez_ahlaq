import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/discount_percent_badge.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_product.dart';

class StoreProductPriceRow extends StatelessWidget {
  final StoreProduct product;

  const StoreProductPriceRow({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    if (product.isOutOfStock) {
      return Text(
        S().outOfStock,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: context.semantic.warning),
      );
    }

    return Row(
      children: [
        Text(
          S().currencyEgp(product.effectivePrice),
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800, color: context.semantic.accentSoft),
        ),
        if (product.isDiscounted) ...[
          SizedBox(width: 8.w),
          Text(
            S().currencyEgp(product.price),
            style: TextStyle(
              fontSize: 14.sp,
              color: scheme.onSurfaceVariant,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          SizedBox(width: 8.w),
          DiscountPercentBadge(percent: product.discountPercent),
        ],
      ],
    );
  }
}
