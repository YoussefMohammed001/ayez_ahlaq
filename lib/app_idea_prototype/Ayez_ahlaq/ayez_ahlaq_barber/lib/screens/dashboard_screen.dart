import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/queue_entry.dart';
import '../state/barber_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/barber_widgets.dart';
import '../widgets/common.dart';
import 'booking_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback onGoToQueue;
  const DashboardScreen({super.key, required this.onGoToQueue});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BarberState>();
    final activeEntries = state.queueToday.asMap().entries.where((e) => e.value.status == QueueStatus.active).toList();
    final nextEntries = state.queueToday
        .asMap()
        .entries
        .where((e) => e.value.status == QueueStatus.next || e.value.status == QueueStatus.upcoming)
        .take(2)
        .toList();

    void openDetail(int index) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => BookingDetailScreen(index: index)));
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('صباح الفل،', style: TextStyle(fontSize: 12, color: AppColors.ivory500)),
                    SizedBox(height: 2),
                    Text('محمد سعيد', style: TextStyle(fontSize: 19, color: AppColors.ivory100, fontWeight: FontWeight.w700)),
                  ],
                ),
                const AvatarCircle(initials: 'م', size: 44),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.brass600),
                gradient: LinearGradient(colors: [AppColors.brass500.withOpacity(0.14), AppColors.ink800]),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('حالتك دلوقتي', style: TextStyle(fontSize: 12.5, color: AppColors.ivory500)),
                            const SizedBox(height: 2),
                            Text(
                              state.available ? 'متاح لحجز جديد' : 'غير متاح دلوقتي',
                              style: AppTextStyles.headingH3.copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      ToggleSwitch(value: state.available, onTap: state.toggleAvailable),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: StatTile(value: '${state.totalToday}', label: 'حجوزات النهاردة')),
                      const SizedBox(width: 10),
                      Expanded(child: StatTile(value: '${state.doneToday}', label: 'خلصت')),
                      const SizedBox(width: 10),
                      Expanded(child: StatTile(value: '${state.expectedEarnings} ج', label: 'الأرباح المتوقعة')),
                    ],
                  ),
                ],
              ),
            ),
            const SectionTitle(title: 'جاري دلوقتي'),
            if (activeEntries.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('مفيش حد على الكرسي دلوقتي', style: TextStyle(color: AppColors.ivory700, fontSize: 11.5), textAlign: TextAlign.center),
              )
            else
              for (final e in activeEntries)
                QueueItemTile(entry: e.value, onTap: () => openDetail(e.key), onFinish: () => state.finishService(e.key)),
            SectionTitle(title: 'التالي في الطابور', actionLabel: 'كل الطابور', onAction: onGoToQueue),
            if (nextEntries.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('مفيش حد في الطابور', style: TextStyle(color: AppColors.ivory700, fontSize: 11.5), textAlign: TextAlign.center),
              )
            else
              for (final e in nextEntries)
                QueueItemTile(
                  entry: e.value,
                  onTap: () => openDetail(e.key),
                  onStart: () => state.startService(e.key),
                  onFinish: () => state.finishService(e.key),
                ),
          ],
        ),
      ),
    );
  }
}
