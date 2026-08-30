import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../state/barber_state.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/common.dart';
import 'add_product_screen.dart';

/// The barber's personal storefront — products he sells himself (pomade,
/// oils, his own kits…) on top of the platform's shared supplies catalog.
class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BarberState>();

    return Scaffold(
      appBar: AppTopBar(
        title: 'منتجاتي',
        trailing: IconButton(
          icon: const Icon(Icons.add, color: AppColors.ivory100),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddProductScreen())),
        ),
      ),
      body: state.myProducts.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.storefront_outlined, size: 40, color: AppColors.ivory700),
                    const SizedBox(height: 12),
                    const Text('لسه مافيش منتجات مضافة', style: TextStyle(color: AppColors.ivory500, fontSize: 13)),
                    const SizedBox(height: 4),
                    const Text('ضيف أول منتج بتاعك وخليه يبان لعملائك', style: TextStyle(color: AppColors.ivory700, fontSize: 11.5), textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brass500,
                        foregroundColor: AppColors.ink950,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddProductScreen())),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('أضف منتج', style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              children: [
                for (final p in state.myProducts) _MyProductRow(product: p, onRemove: () => state.removeMyProduct(p.id)),
              ],
            ),
    );
  }
}

class _MyProductRow extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;
  const _MyProductRow({required this.product, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.hairline)),
      child: Row(
        children: [
          GradientTile(colors: product.gradient, height: 56, width: 56, radius: 12),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, color: AppColors.ivory100, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const TagChip(label: 'معروض'),
                    const SizedBox(width: 6),
                    Text(product.category, style: const TextStyle(fontSize: 10.5, color: AppColors.ivory500)),
                  ],
                ),
                const SizedBox(height: 4),
                Text('${product.price} ج', style: const TextStyle(fontSize: 13, color: AppColors.brass300, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20, color: AppColors.rust400),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
