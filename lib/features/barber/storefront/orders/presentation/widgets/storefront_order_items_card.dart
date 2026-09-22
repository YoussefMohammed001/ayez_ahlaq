import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/app_card.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_fulfillment_type.dart';
import '../../domain/entities/storefront_order.dart';
import 'storefront_order_item_row.dart';

class StorefrontOrderItemsCard extends StatelessWidget {
  final StorefrontOrder order;

  const StorefrontOrderItemsCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        children: [
          for (final item in order.items) StorefrontOrderItemRow(item: item),
          if (order.fulfillmentType == StorefrontFulfillmentType.delivery)
            _buildTotalRow(
              context,
              S().deliveryFeeOrderLabel,
              order.hasDeliveryFee
                  ? S().currencyEgp(order.deliveryFee)
                  : S().freeDelivery,
            ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.hasDeliveryFee ? S().grandTotalLabel : S().orderTotal,
                  style: TextStyle(
                    color: context.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  S().currencyEgp(order.total),
                  style: TextStyle(
                    color: context.semantic.accentSoft,
                    fontWeight: FontWeight.w800,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(BuildContext context, String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.colorScheme.outline)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              color: context.semantic.success,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
