import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../shared/widgets/quantity_stepper.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_product.dart';
import 'store_product_thumbnail.dart';

class StoreProductRow extends StatelessWidget {
  final int shopId;
  final StoreProduct product;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const StoreProductRow({
    super.key,
    required this.shopId,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          StoreProductThumbnail(shopId: shopId, product: product, size: 44.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                SizedBox(height: 3.h),
                if ((product.categoryName ?? '').isNotEmpty)
                  Text(
                    product.categoryName!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
                  ),
                SizedBox(height: 4.h),
                Text(
                  product.isOutOfStock ? S().outOfStock : S().currencyEgp(product.price),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    color: product.isOutOfStock
                        ? context.semantic.warning
                        : context.semantic.accentSoft,
                  ),
                ),
                if (!product.isOutOfStock && product.minOrderQty > 1) ...[
                  SizedBox(height: 3.h),
                  Text(
                    '${S().minOrderQty}: ${product.minOrderQty}',
                    style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
                  ),
                ],
                if (!product.isOutOfStock && quantity > 0) ...[
                  SizedBox(height: 3.h),
                  Text(
                    S().currencyEgp(product.price * quantity),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 8.w),
          if (!product.isOutOfStock)
            QuantityStepper(
              quantity: quantity,
              minQuantity: product.minOrderQty,
              onChanged: onQuantityChanged,
            ),
        ],
      ),
    );
  }
}
