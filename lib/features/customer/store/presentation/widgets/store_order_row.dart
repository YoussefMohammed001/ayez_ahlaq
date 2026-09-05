import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_order.dart';
import 'store_order_status_label.dart';
import 'store_order_status_tone.dart';

class StoreOrderRow extends StatelessWidget {
  final StoreOrder order;
  final VoidCallback onTap;

  const StoreOrderRow({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${order.code} · ${order.shopName}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusBadge(label: order.status.label, tone: order.status.tone),
              Text(
                S().currencyEgp(order.total),
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: context.semantic.accentSoft),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
