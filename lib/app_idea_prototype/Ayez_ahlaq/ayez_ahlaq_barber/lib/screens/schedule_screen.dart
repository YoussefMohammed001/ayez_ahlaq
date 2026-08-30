import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/barber_state.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/barber_widgets.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BarberState>();

    return Scaffold(
      appBar: const AppTopBar(title: 'جدول المواعيد'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
        children: [
          const Text('دوس على أي يوم عشان تفتحه أو تقفله', style: TextStyle(fontSize: 12.5, color: AppColors.ivory500)),
          const SizedBox(height: 14),
          for (var i = 0; i < state.week.length; i++)
            WeekRow(day: state.week[i], onTap: () => state.toggleDay(i)),
          const SizedBox(height: 6),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.ivory100,
              backgroundColor: AppColors.ink700,
              side: const BorderSide(color: AppColors.hairline),
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () {},
            icon: const Icon(Icons.add, size: 16),
            label: const Text('إضافة استراحة أو إجازة', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
