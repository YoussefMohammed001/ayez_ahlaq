import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_order.dart';
import 'store_order_status_badge.dart';

class StoreOrderRow extends StatelessWidget {
  final StoreOrder order;
  final String dateLabel;
  final VoidCallback onTap;

  const StoreOrderRow({
    super.key,
    required this.order,
    required this.dateLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

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
                  '${order.code} · ${order.merchantName}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
                ),
              ),
              Text(
                dateLabel,
                style: TextStyle(fontSize: 10.5.sp, color: scheme.onSurfaceVariant),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StoreOrderStatusBadge(status: order.status),
              Text(
                S().currencyEgp(order.grandTotal),
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: context.semantic.accentSoft),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
