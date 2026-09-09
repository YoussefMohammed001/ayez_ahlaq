import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_product.dart';
import '../../../../../shared/widgets/quantity_stepper.dart';
import 'store_product_thumbnail.dart';

class StoreProductRow extends StatelessWidget {
  final int merchantId;
  final StoreProduct product;
  final int quantity;
  final bool isUpdating;
  final ValueChanged<int> onQuantityChanged;

  const StoreProductRow({
    super.key,
    required this.merchantId,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
    this.isUpdating = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          StoreProductThumbnail(merchantId: merchantId, product: product, size: 44.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
                ),
                SizedBox(height: 3.h),
                Text(
                  product.brand.isEmpty ? product.categoryName : '${product.brand} · ${product.categoryName}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      S().currencyEgp(product.effectivePrice),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: context.semantic.accentSoft,
                      ),
                    ),
                    if (product.isDiscounted) ...[
                      SizedBox(width: 6.w),
                      Text(
                        S().currencyEgp(product.price),
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: scheme.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                if (product.minOrderQty > 1) ...[
                  SizedBox(height: 3.h),
                  Text(
                    '${S().minOrderQty}: ${product.minOrderQty}',
                    style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
                  ),
                ],
                if (quantity > 0) ...[
                  SizedBox(height: 3.h),
                  Text(
                    S().currencyEgp(product.effectivePrice * quantity),
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
          QuantityStepper(
            quantity: quantity,
            minQuantity: product.minOrderQty,
            onChanged: onQuantityChanged,
            disabled: isUpdating,
          ),
        ],
      ),
    );
  }
}
