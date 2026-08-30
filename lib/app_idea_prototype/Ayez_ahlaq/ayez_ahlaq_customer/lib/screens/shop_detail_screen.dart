import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/cards.dart';
import '../widgets/common.dart';
import 'choose_barber_screen.dart';
import 'product_detail_screen.dart';

class ShopDetailScreen extends StatelessWidget {
  const ShopDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final shop = state.selectedShop;
    final isFav = state.isFavorite(shop.id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward, color: AppColors.ivory100),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(shop.name, style: AppTextStyles.headingH3),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? AppColors.rust400 : AppColors.ivory100),
            onPressed: () => state.toggleFavorite(shop.id),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              children: [
                GradientTile(colors: shop.gradient, height: 150, width: double.infinity, radius: 18),
                const SizedBox(height: 14),
                StatusBadge(
                  label: shop.open ? 'مفتوح — يقفل ${shop.closesAt}' : shop.closesAt,
                  tone: shop.open ? BadgeTone.open : BadgeTone.closed,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    StarRating(rating: shop.rating, size: 14),
                    const SizedBox(width: 8),
                    Text('· ${shop.distance} · ${shop.area}', style: AppTextStyles.bodySmall),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(spacing: 6, runSpacing: 6, children: [for (final t in shop.tags) TagChip(label: t)]),
                const SizedBox(height: 16),
                Text(
                  'صالون معتمد من عايز أحلق، أدوات معقّمة بعد كل عميل، وإمكانية تتابع دورك لحظيًا من التطبيق.',
                  style: AppTextStyles.bodySmall.copyWith(fontSize: 12.5, height: 1.8),
                ),
                const SectionTitle(title: 'الحلاقين المتاحين'),
                for (final barber in MockData.barbers)
                  BarberCard(
                    barber: barber,
                    showPortfolio: false,
                    onTap: () {
                      state.selectBarber(barber);
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChooseBarberScreen()));
                    },
                  ),
                if (MockData.barberOwnedProducts.isNotEmpty) ...[
                  const SectionTitle(title: 'منتجات الحلاقين هنا'),
                  Text(
                    'بيبيعوها بنفسهم — لو عجبتك تقدر تطلبها من غير ما تحجز.',
                    style: AppTextStyles.bodySmall.copyWith(fontSize: 11.5),
                  ),
                  const SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.72,
                    children: [
                      for (final entry in MockData.barberOwnedProducts.entries)
                        for (final product in entry.value)
                          ProductCard(
                            product: product,
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductDetailScreen(productId: product.id))),
                            onQuickAdd: () => state.addToCart(product.id),
                          ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          StickyFooter(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brass500,
                foregroundColor: AppColors.ink950,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChooseBarberScreen())),
              child: const Text('اختار الحلاق واحجز', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
