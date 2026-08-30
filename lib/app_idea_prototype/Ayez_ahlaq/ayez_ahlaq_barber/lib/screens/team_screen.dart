import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/team_member.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/barber_widgets.dart';
import '../widgets/common.dart';

/// Team performance dashboard — how many clients each barber at the shop
/// served this month and their rating, sorted best-first so a manager (or
/// a barber curious where they stand) sees the ranking at a glance.
class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final team = [...MockData.team]..sort((a, b) => b.clientsThisMonth.compareTo(a.clientsThisMonth));
    final totalClients = team.fold(0, (sum, m) => sum + m.clientsThisMonth);
    final avgRating = team.fold(0.0, (sum, m) => sum + m.rating) / team.length;
    final maxClients = team.first.clientsThisMonth;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Text('أداء الفريق', style: AppTextStyles.headingH2),
            const SizedBox(height: 4),
            Text('إزاي كل حلاق في الصالون شغال الشهر ده', style: AppTextStyles.bodySmall.copyWith(fontSize: 12.5)),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: StatTile(value: '$totalClients', label: 'إجمالي عملاء الفريق')),
                const SizedBox(width: 10),
                Expanded(child: StatTile(value: avgRating.toStringAsFixed(1), label: 'متوسط التقييم')),
                const SizedBox(width: 10),
                Expanded(child: StatTile(value: '${team.length}', label: 'عدد الحلاقين')),
              ],
            ),
            const SectionTitle(title: 'الترتيب الشهري'),
            for (var i = 0; i < team.length; i++)
              _TeamMemberCard(rank: i + 1, member: team[i], maxClients: maxClients),
          ],
        ),
      ),
    );
  }
}

class _TeamMemberCard extends StatelessWidget {
  final int rank;
  final TeamMember member;
  final int maxClients;

  const _TeamMemberCard({required this.rank, required this.member, required this.maxClients});

  @override
  Widget build(BuildContext context) {
    final share = maxClients == 0 ? 0.0 : member.clientsThisMonth / maxClients;

    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.ink800,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: member.isYou ? AppColors.brass600 : AppColors.hairline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 22,
            child: Text(
              '$rank',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: rank == 1 ? AppColors.brass400 : AppColors.ivory700),
            ),
          ),
          AvatarCircle(initials: member.name.substring(0, 1), size: 46),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(child: Text(member.name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, color: AppColors.ivory100, fontWeight: FontWeight.w700))),
                    if (member.isYou) ...[
                      const SizedBox(width: 6),
                      const StatusBadge(label: 'أنت', tone: BadgeTone.gold, showDot: false),
                    ],
                    if (rank == 1) ...[
                      const SizedBox(width: 6),
                      const Icon(Icons.emoji_events_rounded, size: 15, color: AppColors.brass400),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(member.tag, style: const TextStyle(fontSize: 11, color: AppColors.ivory500)),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: share,
                    minHeight: 6,
                    backgroundColor: AppColors.ink700,
                    valueColor: AlwaysStoppedAnimation(rank == 1 ? AppColors.brass500 : AppColors.brass700),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${member.clientsThisMonth} عميل', style: const TextStyle(fontSize: 12.5, color: AppColors.ivory100, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              StarRating(rating: member.rating, size: 11),
            ],
          ),
        ],
      ),
    );
  }
}
