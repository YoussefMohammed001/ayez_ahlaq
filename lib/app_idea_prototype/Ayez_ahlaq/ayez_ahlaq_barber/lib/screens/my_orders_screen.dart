import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/order.dart';
import '../state/barber_state.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/common.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<BarberState>().orders;

    return Scaffold(
      appBar: const AppTopBar(title: 'طلبات الصالون'),
      body: orders.isEmpty
          ? const Center(child: Text('مفيش طلبات لسه', style: TextStyle(color: AppColors.ivory700, fontSize: 11.5)))
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              children: [for (final o in orders) _OrderCard(order: o)],
            ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final ProductOrder order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final statusText = switch (order.status) {
      OrderStatus.processing => 'جاري التجهيز',
      OrderStatus.shipped => 'في الطريق',
      OrderStatus.delivered => 'اتسلم',
    };
    final itemsLabel = order.items.map((i) => '${i.qty}× ${i.name}').join('، ');

    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.hairline)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.code, style: const TextStyle(color: AppColors.ivory100, fontWeight: FontWeight.w700, fontSize: 13)),
              Text(order.dateLabel, style: const TextStyle(fontSize: 11, color: AppColors.ivory500)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.shopping_bag_outlined, size: 12, color: AppColors.ivory500),
              const SizedBox(width: 6),
              Expanded(child: Text(itemsLabel, style: const TextStyle(fontSize: 11.5, color: AppColors.ivory500))),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusBadge(label: statusText, tone: order.status == OrderStatus.delivered ? BadgeTone.muted : BadgeTone.gold),
              Text('${order.total} ج', style: const TextStyle(fontSize: 13, color: AppColors.brass300, fontWeight: FontWeight.w800)),
            ],
          ),
        ],
      ),
    );
  }
}
