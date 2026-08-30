import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/barber_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/barber_widgets.dart';
import 'booking_detail_screen.dart';
import 'walk_in_screen.dart';

class QueueScreen extends StatelessWidget {
  const QueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BarberState>();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('طابور النهاردة', style: AppTextStyles.headingH2),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.ivory100,
                    backgroundColor: AppColors.ink800,
                    side: const BorderSide(color: AppColors.hairline),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                  ),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WalkInScreen())),
                  icon: const Icon(Icons.directions_walk_rounded, size: 16),
                  label: const Text('عميل من الشارع', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('الأحد 20 أغسطس · صالون الملك', style: AppTextStyles.bodySmall.copyWith(fontSize: 12.5)),
            const SizedBox(height: 14),
            for (var i = 0; i < state.queueToday.length; i++)
              QueueItemTile(
                entry: state.queueToday[i],
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BookingDetailScreen(index: i))),
                onStart: () => state.startService(i),
                onFinish: () => state.finishService(i),
              ),
          ],
        ),
      ),
    );
  }
}
