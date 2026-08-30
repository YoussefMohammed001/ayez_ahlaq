import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/merchant_state.dart';
import '../theme/app_colors.dart';
import '../widgets/common.dart';
import '../widgets/merchant_widgets.dart';
import 'order_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback onGoToOrders;
  const DashboardScreen({super.key, required this.onGoToOrders});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MerchantState>();
    final recent = state.orders.take(3).toList();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('صباح الفل،', style: TextStyle(fontSize: 12, color: AppColors.ivory500)),
                    SizedBox(height: 2),
                    Text('التوريد الذهبي للمستلزمات', style: TextStyle(fontSize: 17, color: AppColors.ivory100, fontWeight: FontWeight.w700)),
                  ],
                ),
                const AvatarCircle(initials: 'ت', size: 44),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'كل عملاؤك هنا حلاقين وصالونات مسجلة على المنصة — البيع بالجملة بس.',
              style: TextStyle(fontSize: 12, color: AppColors.ivory500),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: StatTile(value: '${state.pendingOrdersCount}', label: 'طلبات معلقة')),
                const SizedBox(width: 10),
                Expanded(child: StatTile(value: '${state.revenueThisMonth} ج', label: 'إيرادات الشهر')),
                const SizedBox(width: 10),
                Expanded(child: StatTile(value: '${state.products.where((p) => p.active).length}', label: 'منتج نشط')),
              ],
            ),
            if (state.topProduct != null) ...[
              const SectionTitle(title: 'الأكثر مبيعًا'),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.brass600)),
                child: Row(
                  children: [
                    GradientTile(colors: state.topProduct!.gradient, height: 48, width: 48, radius: 10),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.topProduct!.name, style: const TextStyle(fontSize: 13, color: AppColors.ivory100, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 3),
                          Text('${state.topProduct!.price} ج للوحدة', style: const TextStyle(fontSize: 11, color: AppColors.ivory500)),
                        ],
                      ),
                    ),
                    const Icon(Icons.trending_up_rounded, color: AppColors.brass400),
                  ],
                ),
              ),
            ],
            SectionTitle(title: 'أحدث الطلبات', actionLabel: 'كل الطلبات', onAction: onGoToOrders),
            for (final o in recent)
              OrderCard(order: o, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderDetailScreen(order: o)))),
          ],
        ),
      ),
    );
  }
}
