import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/cards.dart';
import '../widgets/common.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final ids = state.cart.keys.toList();

    return Scaffold(
      appBar: const AppTopBar(title: 'إتمام الطلب'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SectionTitle(title: 'عنوان التوصيل'),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.hairline)),
                  child: const TextField(
                    controller: null,
                    style: TextStyle(color: AppColors.ivory100),
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SectionTitle(title: 'طريقة الدفع'),
                Row(
                  children: [
                    Expanded(
                      child: _PayTile(
                        icon: Icons.payments_outlined,
                        label: 'كاش عند الاستلام',
                        selected: state.storePayment == PaymentMethod.cash,
                        onTap: () => state.setStorePayment(PaymentMethod.cash),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _PayTile(
                        icon: Icons.account_balance_wallet_outlined,
                        label: 'بطاقة/محفظة',
                        selected: state.storePayment == PaymentMethod.card,
                        onTap: () => state.setStorePayment(PaymentMethod.card),
                      ),
                    ),
                  ],
                ),
                const SectionTitle(title: 'ملخص الطلب'),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.hairline)),
                  child: Column(
                    children: [
                      for (final id in ids)
                        _SummaryLine(
                          left: '${state.cart[id]}×',
                          right: MockData.findProductById(id)!.name,
                        ),
                      _SummaryLine(left: 'التوصيل', right: state.deliveryFee == 0 ? 'مجاني' : '${state.deliveryFee} ج'),
                      const Padding(padding: EdgeInsets.only(top: 8), child: Divider(color: AppColors.hairline, height: 1)),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('الإجمالي', style: TextStyle(color: AppColors.ivory300, fontWeight: FontWeight.w700, fontSize: 13)),
                            Text('${state.checkoutTotal} ج', style: const TextStyle(color: AppColors.brass300, fontWeight: FontWeight.w800, fontSize: 20)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          StickyFooter(
            child: Row(
              children: [
                PriceTotalLabel(label: 'الإجمالي', value: '${state.checkoutTotal} ج'),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brass500,
                    foregroundColor: AppColors.ink950,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: ids.isEmpty
                      ? null
                      : () {
                          final order = state.confirmOrder();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => OrderSuccessScreen(orderCode: order.code)),
                          );
                        },
                  child: const Text('تأكيد الطلب', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  final String left;
  final String right;
  const _SummaryLine({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 40, child: Text(left, style: const TextStyle(color: AppColors.ivory500, fontSize: 11.5))),
          const SizedBox(width: 12),
          Expanded(child: Text(right, style: const TextStyle(color: AppColors.ivory100, fontWeight: FontWeight.w600, fontSize: 13.5))),
        ],
      ),
    );
  }
}

class _PayTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _PayTile({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.brass500.withOpacity(0.08) : AppColors.ink800,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? AppColors.brass500 : AppColors.hairline, width: 1.5),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: selected ? AppColors.brass400 : AppColors.ivory300),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.ivory100)),
          ],
        ),
      ),
    );
  }
}
