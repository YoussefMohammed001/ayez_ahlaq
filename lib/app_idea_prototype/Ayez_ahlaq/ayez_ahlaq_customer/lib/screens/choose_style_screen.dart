import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/cards.dart';
import 'choose_time_screen.dart';

/// Style picker inserted between "نوع الخدمة" (service) and "اختار المعاد"
/// (time) — the customer picks the haircut by name (e.g. "مولت") from a
/// small square gallery, and the price updates with the style's add-on.
class ChooseStyleScreen extends StatelessWidget {
  const ChooseStyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: const AppTopBar(title: 'شكل القصة'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ContextBar(text: '${state.selectedService.name} مع ${state.selectedBarber.name}'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              'اختار شكل القصة اللي عايزها بالاسم — الأسعار بتختلف حسب تعقيد القصة',
              style: TextStyle(fontSize: 12.5, color: AppColors.ivory500, height: 1.7),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 14,
                childAspectRatio: 0.78,
              ),
              itemCount: MockData.haircutStyles.length,
              itemBuilder: (context, i) {
                final style = MockData.haircutStyles[i];
                return StyleSwatchCard(
                  style: style,
                  selected: style.id == state.selectedStyle.id,
                  onTap: () => state.selectStyle(style),
                );
              },
            ),
          ),
          StickyFooter(
            child: Row(
              children: [
                PriceTotalLabel(label: 'الإجمالي المتوقع', value: '${state.totalServicePrice} ج · ${state.selectedService.durationMinutes} د'),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brass500,
                    foregroundColor: AppColors.ink950,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChooseTimeScreen())),
                  child: const Text('التالي', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
