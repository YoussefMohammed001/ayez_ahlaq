import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/app_card.dart';
import '../../../../../../core/widgets/status_badge.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_order.dart';
import 'storefront_order_items_label.dart';
import 'storefront_order_status_label.dart';
import 'storefront_order_status_tone.dart';

class StorefrontOrderCard extends StatelessWidget {
  final StorefrontOrder order;
  final String dateLabel;
  final VoidCallback onTap;

  const StorefrontOrderCard({
    super.key,
    required this.order,
    required this.dateLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  order.customerName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                dateLabel,
                style: TextStyle(
                  fontSize: 10.5.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            order.itemsLabel,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.5.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusBadge(label: order.status.label, tone: order.status.tone),
              Text(
                S().currencyEgp(order.total),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.semantic.accentSoft,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
