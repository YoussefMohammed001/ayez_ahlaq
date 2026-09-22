import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../generated/l10n.dart';
import 'package:ayez_ahlaq/shared/widgets/profile_menu_section_screen.dart';

class BarberAccountMenuScreen extends StatelessWidget {
  const BarberAccountMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuSectionScreen(
      title: S().accountManagementSection,
      rows: [
        MenuRow(
          icon: Icons.badge_outlined,
          label: S().profileDetailsTitle,
          onTap: () => context.push(Routes.barberProfileDetailsScreen),
        ),
        MenuRow(
          icon: Icons.lock_outline_rounded,
          label: S().changePassword,
          onTap: () => context.push(Routes.barberChangePasswordScreen),
        ),
        MenuRow(
          icon: Icons.delete_forever_rounded,
          label: S().deleteAccount,
          danger: true,
          onTap: () => context.push(Routes.barberDeleteAccountScreen),
        ),
      ],
    );
  }
}
