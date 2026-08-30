import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/barber_state.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/barber_widgets.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BarberState>();

    return Scaffold(
      appBar: const AppTopBar(title: 'خدماتي وأسعاري'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        children: [
          for (var i = 0; i < state.services.length; i++)
            ServiceRow(service: state.services[i], onToggle: () => state.toggleServiceActive(i)),
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
            label: const Text('إضافة خدمة جديدة', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
