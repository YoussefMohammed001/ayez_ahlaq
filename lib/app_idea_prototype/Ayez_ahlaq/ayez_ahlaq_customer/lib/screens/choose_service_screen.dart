import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/cards.dart';
import 'choose_style_screen.dart';

class ChooseServiceScreen extends StatelessWidget {
  const ChooseServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: const AppTopBar(title: 'نوع الخدمة'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ContextBar(text: 'مع ${state.selectedBarber.name} · ${state.selectedShop.name}'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                for (final service in MockData.services)
                  ServiceCard(
                    service: service,
                    selected: service.id == state.selectedService.id,
                    onTap: () => state.selectService(service),
                  ),
              ],
            ),
          ),
          StickyFooter(
            child: Row(
              children: [
                PriceTotalLabel(label: 'الإجمالي المتوقع', value: '${state.selectedService.price} ج · ${state.selectedService.durationMinutes} د'),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brass500,
                    foregroundColor: AppColors.ink950,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChooseStyleScreen())),
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
