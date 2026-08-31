import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../domain/entities/fulfilment_type.dart';
import '../../domain/entities/order_item.dart';
import '../../domain/entities/purchase_order.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class OrderItemsCard extends StatelessWidget {
  final PurchaseOrder order;

  const OrderItemsCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        children: [
          for (final item in order.items) _buildItemRow(context, item),
          if (order.orderDiscount > 0)
            _buildTotalRow(context, S().orderDiscountLabel, '-${S().currencyEgp(order.orderDiscount)}'),
          if (order.fulfilmentType == FulfilmentType.delivery)
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

  Widget _buildItemRow(BuildContext context, OrderItem item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.colorScheme.outline)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    item.productName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                if (item.gift) ...[
                  SizedBox(width: 6.w),
                  Icon(
                    Icons.card_giftcard,
                    size: 14.r,
                    color: context.semantic.success,
                  ),
                ],
              ],
            ),
          ),
          Text(
            '${item.quantity} ×',
            style: TextStyle(
              fontSize: 12.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
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
