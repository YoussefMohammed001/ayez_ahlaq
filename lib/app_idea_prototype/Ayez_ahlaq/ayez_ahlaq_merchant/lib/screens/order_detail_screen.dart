import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/purchase_order.dart';
import '../state/merchant_state.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/common.dart';

class OrderDetailScreen extends StatelessWidget {
  final PurchaseOrder order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MerchantState>();
    final tone = switch (order.status) {
      OrderStatus.processing => BadgeTone.gold,
      OrderStatus.shipped => BadgeTone.info,
      OrderStatus.delivered => BadgeTone.muted,
    };

    return Scaffold(
      appBar: AppTopBar(title: order.code),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        children: [
          Row(
            children: [
              AvatarCircle(initials: order.shopName.substring(0, 1), size: 52),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.shopName, style: const TextStyle(fontSize: 15, color: AppColors.ivory100, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text('الحلاق المسؤول: ${order.barberName}', style: const TextStyle(fontSize: 11.5, color: AppColors.ivory500)),
                  ],
                ),
              ),
              StatusBadge(label: order.status.label, tone: tone),
            ],
          ),
          const SectionTitle(title: 'الأصناف المطلوبة'),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.hairline)),
            child: Column(
              children: [
                for (final item in order.items)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.hairline))),
                    child: Row(
                      children: [
                        Expanded(child: Text(item.productName, style: const TextStyle(fontSize: 13, color: AppColors.ivory100))),
                        Text('${item.qty} ×', style: const TextStyle(fontSize: 12, color: AppColors.ivory500)),
                        const SizedBox(width: 10),
                        Text('${item.qty * item.price} ج', style: const TextStyle(fontSize: 13, color: AppColors.brass300, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('الإجمالي', style: TextStyle(color: AppColors.ivory300, fontWeight: FontWeight.w700, fontSize: 13)),
                      Text('${order.total} ج', style: const TextStyle(color: AppColors.brass300, fontWeight: FontWeight.w800, fontSize: 18)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (order.status.next != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brass500,
                foregroundColor: AppColors.ink950,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () => state.advanceOrderStatus(order),
              child: Text('نقل الحالة لـ "${order.status.next!.label}"', style: const TextStyle(fontWeight: FontWeight.w700)),
            )
          else
            const Center(child: Text('الطلب اتسلم بالكامل ✅', style: TextStyle(color: AppColors.moss500, fontWeight: FontWeight.w700))),
        ],
      ),
    );
  }
}
