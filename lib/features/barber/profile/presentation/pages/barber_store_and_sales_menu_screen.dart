import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../generated/l10n.dart';
import 'package:ayez_ahlaq/shared/widgets/profile_menu_section_screen.dart';

class BarberStoreAndSalesMenuScreen extends StatelessWidget {
  const BarberStoreAndSalesMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuSectionScreen(
      title: S().storeAndSalesSection,
      rows: [
        MenuRow(
          icon: Icons.storefront_outlined,
          label: S().storefrontTitle,
          onTap: () => context.push(Routes.barberStorefrontHomeScreen),
        ),
        MenuRow(
          icon: Icons.local_cafe_outlined,
          label: S().drinksTitle,
          onTap: () => context.push(Routes.barberDrinksScreen),
        ),
        MenuRow(
          icon: Icons.local_offer_outlined,
          label: S().discountsTitle,
          onTap: () => context.push(Routes.barberDiscountsScreen),
        ),
      ],
    );
  }
}
