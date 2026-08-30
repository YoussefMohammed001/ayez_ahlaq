import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../state/app_state.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/cards.dart';
import 'choose_service_screen.dart';

class ChooseBarberScreen extends StatelessWidget {
  const ChooseBarberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: const AppTopBar(title: 'اختار الحلاق'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ContextBar(text: 'بتحجز في ${state.selectedShop.name}'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                for (final barber in MockData.barbers)
                  BarberCard(
                    barber: barber,
                    onTap: () {
                      state.selectBarber(barber);
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChooseServiceScreen()));
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
