import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/common.dart';
import 'services_screen.dart';
import 'reviews_screen.dart';
import 'schedule_screen.dart';
import 'share_screen.dart';
import 'my_products_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 20),
            const Center(child: AvatarCircle(initials: 'م', size: 84)),
            const SizedBox(height: 10),
            Center(child: Text('محمد سعيد', style: AppTextStyles.headingH3.copyWith(fontSize: 19))),
            const SizedBox(height: 3),
            const Center(child: Text('صالون الملك · مدينة نصر', style: TextStyle(fontSize: 12.5, color: AppColors.ivory500))),
            const SizedBox(height: 6),
            const Center(child: StarRating(rating: 4.9, size: 14)),
            const SizedBox(height: 8),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: 6,
              children: const [TagChip(label: 'فيد وتصفيف عصري'), TagChip(label: 'قصات كلاسيك'), TagChip(label: 'ذقن')],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(child: _MiniStat(value: '7', label: 'سنين خبرة')),
                SizedBox(width: 10),
                Expanded(child: _MiniStat(value: '1240', label: 'عميل خدمهم')),
                SizedBox(width: 10),
                Expanded(child: _MiniStat(value: '4.9', label: 'تقييمه')),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'متخصص في الفيد والتصفيف العصري، بشتغل بأدوات معقّمة 100% وبراعي وقت العميل. متاح للحجز من خلال رابطي الشخصي كمان.',
              style: TextStyle(fontSize: 12.5, color: AppColors.ivory500, height: 1.8),
            ),
            const SectionTitle(title: 'شغلي'),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [for (final c in MockData.portfolio) Container(decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(12)))],
            ),
            const SectionTitle(title: 'الإدارة'),
            _MenuRow(icon: Icons.storefront_outlined, label: 'منتجاتي', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MyProductsScreen()))),
            _MenuRow(icon: Icons.edit_outlined, label: 'خدماتي وأسعاري', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ServicesScreen()))),
            _MenuRow(icon: Icons.star_border_rounded, label: 'تقييمات العملاء', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ReviewsScreen()))),
            _MenuRow(icon: Icons.calendar_month_outlined, label: 'جدول المواعيد', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ScheduleScreen()))),
            _MenuRow(icon: Icons.ios_share_rounded, label: 'مشاركة رابطي', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ShareScreen()))),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String value;
  final String label;
  const _MiniStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.hairline)),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 18, color: AppColors.brass300, fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.ivory500)),
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuRow({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.hairline))),
        child: Row(
          children: [
            Icon(icon, size: 19, color: AppColors.ivory300),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: const TextStyle(color: AppColors.ivory100, fontSize: 13.5, fontWeight: FontWeight.w600))),
            const Icon(Icons.chevron_left, size: 16, color: AppColors.ivory700),
          ],
        ),
      ),
    );
  }
}
