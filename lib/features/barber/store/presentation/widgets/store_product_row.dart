import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_product.dart';
import 'quantity_stepper.dart';

class StoreProductRow extends StatelessWidget {
  final StoreProduct product;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const StoreProductRow({
    super.key,
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
          Container(
            width: 44.r,
            height: 44.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.inventory_2_outlined, size: 22.r, color: scheme.onSurfaceVariant),
          ),
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
              ],
            ),
          ),
          SizedBox(width: 8.w),
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
