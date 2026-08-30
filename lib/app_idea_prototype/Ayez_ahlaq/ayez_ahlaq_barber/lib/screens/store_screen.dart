import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../state/barber_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/store_widgets.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';

/// A main bottom-nav tab — deliberately the same browse/buy experience as
/// the customer app's Store tab (supplies only; the barber's own products
/// live in "منتجاتي" under Profile instead).
class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BarberState>();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('المتجر', style: AppTextStyles.headingH2),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen())),
                  child: Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.hairline)),
                    child: Badge(
                      isLabelVisible: state.cartCount > 0,
                      label: Text('${state.cartCount}'),
                      backgroundColor: AppColors.rust500,
                      child: const Icon(Icons.shopping_bag_outlined, color: AppColors.ivory100, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text('اطلب مستلزمات صالونك — منتجات وأدوات أصلية بأسعار الجملة', style: TextStyle(fontSize: 12.5, color: AppColors.ivory500)),
            const SizedBox(height: 14),
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: MockData.productCategories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final c = MockData.productCategories[i];
                final selected = c == state.selectedCategory;
                return GestureDetector(
                  onTap: () => state.selectCategory(c),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.brass500 : AppColors.ink800,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: selected ? AppColors.brass500 : AppColors.hairline),
                    ),
                    alignment: Alignment.center,
                    child: Text(c, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: selected ? AppColors.ink950 : AppColors.ivory300)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.72,
            children: [
              for (final p in state.filteredProducts)
                ProductCard(
                  product: p,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: p.id))),
                  onQuickAdd: () => state.addToCart(p.id),
                ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}
