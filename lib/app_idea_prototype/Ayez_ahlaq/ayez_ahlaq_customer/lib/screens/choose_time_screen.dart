import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/cards.dart';
import '../widgets/common.dart';
import 'booking_summary_screen.dart';

class ChooseTimeScreen extends StatelessWidget {
  const ChooseTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: const AppTopBar(title: 'اختار المعاد'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ContextBar(text: '${state.selectedService.name} مع ${state.selectedBarber.name}'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                SizedBox(
                  height: 68,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (final d in MockData.dates)
                        DateChip(date: d, selected: d.id == state.selectedDateId, onTap: () => state.selectDate(d.id)),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: AppColors.ink800,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.hairline),
                  ),
                  child: Row(
                    children: [
                      Container(width: 9, height: 9, decoration: const BoxDecoration(color: AppColors.moss500, shape: BoxShape.circle)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.ivory300, fontSize: 12.5, height: 1.6),
                            children: [
                              TextSpan(text: state.selectedBarber.status, style: const TextStyle(color: AppColors.ivory100, fontWeight: FontWeight.w700)),
                              const TextSpan(text: ' — لو حجزت أقرب معاد، هيجيلك الدور خلال شوية'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SectionTitle(title: 'المواعيد المتاحة النهاردة'),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.9,
                  children: [
                    for (final slot in MockData.timeSlots)
                      TimeChip(
                        slot: slot,
                        selected: slot.time == state.selectedTime,
                        onTap: () => state.selectTime(slot.time),
                      ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: const [
                    _LegendDot(color: AppColors.ink800, bordered: true, label: 'متاح'),
                    SizedBox(width: 14),
                    _LegendDot(color: AppColors.brass500, label: 'مختار'),
                    SizedBox(width: 14),
                    _LegendDot(color: AppColors.ink700, label: 'محجوز'),
                  ],
                ),
              ],
            ),
          ),
          StickyFooter(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brass500,
                foregroundColor: AppColors.ink950,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: state.selectedTime == null
                  ? null
                  : () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BookingSummaryScreen())),
              child: const Text('التالي', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  final bool bordered;
  const _LegendDot({required this.color, required this.label, this.bordered = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            border: bordered ? Border.all(color: AppColors.hairline) : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.ivory500)),
      ],
    );
  }
}
