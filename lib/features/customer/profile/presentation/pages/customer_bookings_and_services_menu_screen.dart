import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/core/widgets/menu_row.dart';
import 'package:ayez_ahlaq/shared/widgets/profile_menu_section_screen.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class CustomerBookingsAndServicesMenuScreen extends StatelessWidget {
  const CustomerBookingsAndServicesMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuSectionScreen(
      title: S().bookingsAndServicesSection,
      rows: [
        MenuRow(
          icon: Icons.event_note_outlined,
          label: S().bookingsTitle,
          onTap: () => context.push(Routes.customerBookingsScreen),
        ),
        MenuRow(
          icon: Icons.home_repair_service_outlined,
          label: S().homeServiceShopListTitle,
          onTap: () => context.push(Routes.customerHomeServiceShopListScreen),
        ),
        MenuRow(
          icon: Icons.account_balance_wallet_outlined,
          label: S().walletTitle,
          onTap: () => context.push(Routes.customerWalletScreen),
        ),
        MenuRow(
          icon: Icons.star_border_rounded,
          label: S().reviewsTitle,
          onTap: () => context.push(Routes.customerRatingsScreen),
        ),
      ],
    );
  }
}
