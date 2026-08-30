import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/merchant_state.dart';
import '../theme/app_text_styles.dart';
import '../widgets/merchant_widgets.dart';
import 'order_detail_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MerchantState>();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Text('طلبات الحلاقين', style: AppTextStyles.headingH2),
            const SizedBox(height: 4),
            Text('كل الطلبات اللي وصلتك من الصالونات', style: AppTextStyles.bodySmall.copyWith(fontSize: 12.5)),
            const SizedBox(height: 14),
            for (final o in state.orders)
              OrderCard(order: o, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderDetailScreen(order: o)))),
          ],
        ),
      ),
    );
  }
}
