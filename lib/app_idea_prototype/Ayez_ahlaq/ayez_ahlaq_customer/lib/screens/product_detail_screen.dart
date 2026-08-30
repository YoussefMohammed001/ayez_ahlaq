import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/cards.dart';
import '../widgets/common.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final product = MockData.findProductById(widget.productId)!;
    final inCart = state.cart[product.id] ?? 0;

    return Scaffold(
      appBar: AppTopBar(
        title: 'تفاصيل المنتج',
        trailing: IconButton(
          icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.ivory100),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen())),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          GradientTile(colors: product.gradient, height: 220, width: double.infinity, radius: 20),
          const SizedBox(height: 16),
          Text(product.name, style: AppTextStyles.headingH2.copyWith(fontSize: 19)),
          const SizedBox(height: 8),
          Row(
            children: [
              StarRating(rating: product.rating, size: 13),
              const SizedBox(width: 10),
              Text('${product.price} ج', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.brass300)),
            ],
          ),
          const SizedBox(height: 14),
          Text(product.description, style: const TextStyle(fontSize: 13, color: AppColors.ivory500, height: 1.9)),
          if (inCart > 0) ...[
            const SizedBox(height: 12),
            StatusBadge(label: '$inCart في السلة بالفعل', tone: BadgeTone.open),
          ],
          const SectionTitle(title: 'الكمية'),
          QtyStepper(value: qty, onChanged: (v) => setState(() => qty = v < 1 ? 1 : v)),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brass500,
              foregroundColor: AppColors.ink950,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () {
              state.addToCart(product.id, qty: qty);
              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_bag_outlined, size: 16),
                const SizedBox(width: 8),
                Text('أضف للسلة · ${product.price * qty} ج', style: const TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
