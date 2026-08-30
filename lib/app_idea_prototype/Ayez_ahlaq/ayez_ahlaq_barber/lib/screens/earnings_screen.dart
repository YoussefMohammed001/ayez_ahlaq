import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/queue_entry.dart';
import '../state/barber_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/barber_widgets.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BarberState>();
    final done = state.queueToday.where((q) => q.status == QueueStatus.done).toList();
    final doneTotal = done.fold(0, (sum, q) => sum + q.price);
    final avgTicket = done.isEmpty ? 0 : (doneTotal / done.length).round();

    const week7 = [
      MapEntry('سبت', 52),
      MapEntry('حد', 88),
      MapEntry('اتنين', 40),
      MapEntry('تلات', 65),
      MapEntry('أربع', 70),
      MapEntry('خميس', 95),
      MapEntry('جمعة', 30),
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Text('أرباحي', style: AppTextStyles.headingH2),
            const SizedBox(height: 18),
            Column(
              children: [
                const Text('أرباح النهاردة', style: TextStyle(fontSize: 12, color: AppColors.ivory500)),
                Text('$doneTotal ج', style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w700, color: AppColors.brass300)),
                const Text('▲ 12% عن أمبارح', style: TextStyle(fontSize: 11.5, color: AppColors.moss500, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 18),
            const EarningsBarChart(data: week7, todayIndex: 1),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(child: StatTile(value: '${done.length}', label: 'خدمة مكتملة')),
                const SizedBox(width: 10),
                Expanded(child: StatTile(value: '$avgTicket ج', label: 'متوسط الفاتورة')),
              ],
            ),
            const SizedBox(height: 18),
            const Text('معاملات النهاردة', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ivory100)),
            const SizedBox(height: 10),
            if (done.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('لسه مفيش خدمات خلصت', style: TextStyle(color: AppColors.ivory700, fontSize: 11.5), textAlign: TextAlign.center),
              )
            else
              for (final q in done)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.hairline))),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(q.customerName, style: const TextStyle(fontSize: 12.5, color: AppColors.ivory100, fontWeight: FontWeight.w600)),
                            Text('${q.service} · ${q.time} م', style: const TextStyle(fontSize: 10.5, color: AppColors.ivory500)),
                          ],
                        ),
                      ),
                      Text('${q.price} ج', style: const TextStyle(fontSize: 13, color: AppColors.brass300, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
