import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/common.dart';

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
            const Center(child: AvatarCircle(initials: 'ت', size: 84)),
            const SizedBox(height: 10),
            const Center(child: Text('التوريد الذهبي للمستلزمات', style: TextStyle(color: AppColors.ivory100, fontSize: 17, fontWeight: FontWeight.w700))),
            const SizedBox(height: 3),
            const Center(child: Text('توريد مستلزمات حلاقة بالجملة', style: TextStyle(color: AppColors.ivory500, fontSize: 12.5))),
            const SizedBox(height: 8),
            const Center(child: StatusBadge(label: 'حساب تاجر موثّق', tone: BadgeTone.open)),
            const SizedBox(height: 18),
            const _InfoRow(icon: Icons.badge_outlined, label: 'رقم السجل التجاري', value: '29841-CR'),
            const _InfoRow(icon: Icons.call_outlined, label: 'التواصل', value: '01033445566'),
            const _InfoRow(icon: Icons.location_on_outlined, label: 'العنوان', value: 'العبور، القاهرة'),
            const SectionTitle(title: 'الإدارة'),
            const _MenuRow(icon: Icons.groups_outlined, label: 'الحلاقين المتعاملين معايا'),
            const _MenuRow(icon: Icons.notifications_none_rounded, label: 'الإشعارات'),
            const _MenuRow(icon: Icons.info_outline_rounded, label: 'عن التطبيق'),
            const _MenuRow(icon: Icons.logout_rounded, label: 'تسجيل الخروج', danger: true, showChevron: false),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.hairline))),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.ivory300),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12.5, color: AppColors.ivory500))),
          Text(value, style: const TextStyle(fontSize: 12.5, color: AppColors.ivory100, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool danger;
  final bool showChevron;
  const _MenuRow({required this.icon, required this.label, this.danger = false, this.showChevron = true});

  @override
  Widget build(BuildContext context) {
    final color = danger ? AppColors.rust400 : AppColors.ivory100;
    return Container(
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
    );
  }
}
