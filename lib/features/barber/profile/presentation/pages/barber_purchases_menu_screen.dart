import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../generated/l10n.dart';
import 'package:ayez_ahlaq/shared/widgets/profile_menu_section_screen.dart';

class BarberPurchasesMenuScreen extends StatelessWidget {
  const BarberPurchasesMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuSectionScreen(
      title: S().purchasesSection,
      rows: [
        MenuRow(
          icon: Icons.storefront_outlined,
          label: S().storeTitle,
          onTap: () => context.push(Routes.barberStoreMerchantsScreen),
        ),
      ],
    );
  }
}
