import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../generated/l10n.dart';
import 'package:ayez_ahlaq/shared/widgets/profile_menu_section_screen.dart';

class BarberFinancialMenuScreen extends StatelessWidget {
  const BarberFinancialMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuSectionScreen(
      title: S().financialSection,
      rows: [
        MenuRow(
          icon: Icons.payments_outlined,
          label: S().earningsTitle,
          onTap: () => context.push(Routes.barberEarningsPinScreen),
        ),
        MenuRow(
          icon: Icons.account_balance_wallet_outlined,
          label: S().walletTitle,
          onTap: () => context.push(Routes.barberWalletPinScreen),
        ),
        MenuRow(
          icon: Icons.lock_clock_outlined,
          label: S().moneyManagerTitle,
          onTap: () => context.push(Routes.barberMoneyPinScreen),
        ),
        MenuRow(
          icon: Icons.workspace_premium_outlined,
          label: S().subscriptionTitle,
          onTap: () => context.push(Routes.barberSubscriptionScreen),
        ),
        MenuRow(
          icon: Icons.trending_up_rounded,
          label: S().sponsorshipTitle,
          onTap: () => context.push(Routes.barberSponsorshipScreen),
        ),
      ],
    );
  }
}
