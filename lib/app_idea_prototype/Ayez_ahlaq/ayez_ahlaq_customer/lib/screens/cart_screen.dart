import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/cards.dart';
import '../widgets/common.dart';
import 'checkout_screen.dart';
import 'main_shell.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final ids = state.cart.keys.toList();

    return Scaffold(
      appBar: const AppTopBar(title: 'السلة'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ids.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('السلة فاضية دلوقتي', style: TextStyle(color: AppColors.ivory700, fontSize: 12.5)),
                          const SizedBox(height: 16),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.ivory100,
                              side: const BorderSide(color: AppColors.hairline),
                              backgroundColor: AppColors.ink700,
                            ),
                            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => const MainShell(initialIndex: 2)),
                              (route) => false,
                            ),
                            child: const Text('تسوق دلوقتي'),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      for (final id in ids) _CartRow(productId: id, qty: state.cart[id]!),
                    ],
                  ),
          ),
          if (ids.isNotEmpty)
            StickyFooter(
              child: Row(
                children: [
                  PriceTotalLabel(label: 'الإجمالي', value: '${state.cartTotal} ج'),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brass500,
                      foregroundColor: AppColors.ink950,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CheckoutScreen())),
                    child: const Text('الدفع', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _CartRow extends StatelessWidget {
  final String productId;
  final int qty;
  const _CartRow({required this.productId, required this.qty});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    final product = MockData.findProductById(productId)!;
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.hairline)),
      child: Row(
        children: [
          GradientTile(colors: product.gradient, height: 52, width: 52, radius: 10),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12.5, color: AppColors.ivory100)),
                const SizedBox(height: 5),
                Text('${product.price} ج', style: const TextStyle(fontSize: 11, color: AppColors.ivory500)),
              ],
            ),
          ),
          QtyStepper(value: qty, buttonSize: 22, onChanged: (v) => state.changeCartQty(productId, v - qty)),
          IconButton(
            icon: const Icon(Icons.close, size: 18, color: AppColors.rust400),
            onPressed: () => state.removeFromCart(productId),
          ),
        ],
      ),
    );
  }
}
