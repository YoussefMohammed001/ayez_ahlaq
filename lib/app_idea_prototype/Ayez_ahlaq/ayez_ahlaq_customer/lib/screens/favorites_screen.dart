import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/cards.dart';
import '../widgets/common.dart';
import 'shop_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final pinned = MockData.allShops[MockData.viaLinkShopId]!;
    final others = state.favoriteShopIds.where((id) => id != MockData.viaLinkShopId).toList();

    void openShop(String shopId) {
      state.selectShop(MockData.allShops[shopId]!);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ShopDetailScreen()));
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Text('المفضلة', style: AppTextStyles.headingH2),
            const SizedBox(height: 4),
            Text('الصالونات والحلاقين اللي حفظتهم عشان تحجز بسرعة', style: AppTextStyles.bodySmall.copyWith(fontSize: 12.5)),
            const SizedBox(height: 14),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => openShop(pinned.id),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.brass600),
                    gradient: LinearGradient(
                      colors: [AppColors.brass400.withOpacity(0.14), AppColors.brass400.withOpacity(0.03)],
                    ),
                  ),
                  child: Row(
                    children: [
                      AvatarCircle(initials: pinned.name.substring(0, 1), size: 52),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pinned.name, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700, fontSize: 14)),
                            const SizedBox(height: 3),
                            Text('حلاقك المفضّل · اتضاف من رابط الدعوة', style: AppTextStyles.bodySmall.copyWith(color: AppColors.brass300, fontSize: 11.5)),
                          ],
                        ),
                      ),
                      const StatusBadge(label: 'رابط', tone: BadgeTone.gold, showDot: false),
                    ],
                  ),
                ),
              ),
            ),
            if (others.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('مفيش صالونات تانية محفوظة لسه', style: AppTextStyles.bodySmall.copyWith(color: AppColors.ivory700), textAlign: TextAlign.center),
              )
            else
              for (final id in others)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ShopCard(
                    shop: MockData.allShops[id]!,
                    isFavorite: true,
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
