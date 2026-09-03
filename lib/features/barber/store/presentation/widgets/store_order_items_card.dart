import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/fulfillment_type.dart';
import '../../domain/entities/store_order.dart';
import '../../domain/entities/store_order_item.dart';

class StoreOrderItemsCard extends StatelessWidget {
  final StoreOrder order;

  const StoreOrderItemsCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        children: [
          for (final item in order.items) _buildItemRow(context, item),
          if (order.orderDiscount > 0)
            _buildTotalRow(context, S().orderDiscountLabel, '-${S().currencyEgp(order.orderDiscount)}'),
          if (order.fulfillmentType == FulfillmentType.delivery)
            _buildTotalRow(
              context,
              S().deliveryFeeOrderLabel,
              order.hasDeliveryFee ? S().currencyEgp(order.deliveryFee) : S().freeDelivery,
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
                  S().currencyEgp(order.grandTotal),
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

  Widget _buildItemRow(BuildContext context, StoreOrderItem item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.colorScheme.outline)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.productName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13.sp, color: context.colorScheme.onSurface),
            ),
          ),
          Text(
            '${item.quantity} ×',
            style: TextStyle(fontSize: 12.sp, color: context.colorScheme.onSurfaceVariant),
          ),
          SizedBox(width: 10.w),
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
            style: TextStyle(fontSize: 12.5.sp, color: context.colorScheme.onSurfaceVariant),
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
