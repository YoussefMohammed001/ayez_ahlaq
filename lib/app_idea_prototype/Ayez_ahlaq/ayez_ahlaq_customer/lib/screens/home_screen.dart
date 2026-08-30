import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/cards.dart';
import '../widgets/common.dart';
import 'shop_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onGoToFavorites;
  const HomeScreen({super.key, required this.onGoToFavorites});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    void openShop(String shopId) {
      state.selectShop(MockData.allShops[shopId]!);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ShopDetailScreen()));
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.location_on_outlined, size: 15, color: AppColors.brass400),
                          SizedBox(width: 6),
                          Text('مدينة نصر، القاهرة', style: TextStyle(color: AppColors.brass400, fontSize: 12.5, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text('تقدر تغيّر موقعك من الإعدادات', style: AppTextStyles.bodySmall.copyWith(fontSize: 11, color: AppColors.ivory700)),
                    ],
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.ink800,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.hairline),
                  ),
                  child: const Icon(Icons.notifications_none_rounded, color: AppColors.ivory100, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.ink800,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.hairline),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, size: 18, color: AppColors.ivory500),
                  SizedBox(width: 8),
                  Text('دور على صالون أو حلاق معيّن...', style: TextStyle(color: AppColors.ivory500, fontSize: 13.5)),
                ],
              ),
            ),
            SectionTitle(title: 'المفضلة بتاعتك', actionLabel: 'كل المفضلة', onAction: onGoToFavorites),
            SizedBox(
              height: 232,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.favoriteShopIds.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, i) {
                  final id = state.favoriteShopIds.elementAt(i);
                  final shop = MockData.allShops[id]!;
                  return SizedBox(
                    width: 150,
                    child: ShopCard(
                      shop: shop,
                      isFavorite: true,
                      onTap: () => openShop(id),
                      onToggleFavorite: () => state.toggleFavorite(id),
                    ),
                  );
                },
              ),
            ),
            const SectionTitle(title: 'الأقرب ليك دلوقتي'),
            for (final id in MockData.nearbyShopIds)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ShopCard(
                  shop: MockData.allShops[id]!,
                  isFavorite: state.isFavorite(id),
                  onTap: () => openShop(id),
                  onToggleFavorite: () => state.toggleFavorite(id),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
