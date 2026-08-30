import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/common.dart';
import 'my_orders_screen.dart';

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
            const Center(child: AvatarCircle(initials: 'م', size: 76)),
            const SizedBox(height: 12),
            const Center(child: Text('مختار توفيق', style: TextStyle(color: AppColors.ivory100, fontSize: 17, fontWeight: FontWeight.w700))),
            const SizedBox(height: 3),
            const Center(child: Text('01012345678', style: TextStyle(color: AppColors.ivory500, fontSize: 12.5))),
            const SizedBox(height: 18),
            _ProfileRow(
              icon: Icons.shopping_bag_outlined,
              label: 'طلباتي',
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MyOrdersScreen())),
            ),
            const _ProfileRow(icon: Icons.notifications_none_rounded, label: 'الإشعارات'),
            const _ProfileRow(icon: Icons.account_balance_wallet_outlined, label: 'طرق الدفع'),
            const _ProfileRow(icon: Icons.language_rounded, label: 'اللغة — العربية'),
            const _ProfileRow(icon: Icons.info_outline_rounded, label: 'عن التطبيق'),
            const _ProfileRow(icon: Icons.logout_rounded, label: 'تسجيل الخروج', danger: true, showChevron: false),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool danger;
  final bool showChevron;
  final VoidCallback? onTap;

  const _ProfileRow({required this.icon, required this.label, this.danger = false, this.showChevron = true, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = danger ? AppColors.rust400 : AppColors.ivory100;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.hairline))),
        child: Row(
          children: [
            Icon(icon, size: 19, color: danger ? AppColors.rust400 : AppColors.ivory300),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: TextStyle(color: color, fontSize: 13.5, fontWeight: FontWeight.w600))),
            if (showChevron) const Icon(Icons.chevron_left, size: 16, color: AppColors.ivory700),
          ],
        ),
      ),
    );
  }
}
