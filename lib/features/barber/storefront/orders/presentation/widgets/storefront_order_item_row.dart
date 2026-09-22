import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_order_item.dart';

class StorefrontOrderItemRow extends StatelessWidget {
  final StorefrontOrderItem item;

  const StorefrontOrderItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.colorScheme.outline)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              item.productName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (item.hasUnitDiscount)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  textDirection: TextDirection.ltr,
                  children: [
                    Text(
                      S().currencyEgp(item.unitPrice),
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        color: context.colorScheme.onSurfaceVariant,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${item.quantity} × ${S().currencyEgp(item.effectiveUnitPrice)}',
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                )
              else
                Text(
                  '${item.quantity} × ${S().currencyEgp(item.unitPrice)}',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              SizedBox(height: 2.h),
              Text(
                S().currencyEgp(item.lineTotal),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: context.semantic.accentSoft,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
