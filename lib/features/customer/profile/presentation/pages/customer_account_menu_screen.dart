import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/core/widgets/menu_row.dart';
import 'package:ayez_ahlaq/shared/widgets/profile_menu_section_screen.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class CustomerAccountMenuScreen extends StatelessWidget {
  const CustomerAccountMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuSectionScreen(
      title: S().accountManagementSection,
      rows: [
        MenuRow(
          icon: Icons.lock_outline_rounded,
          label: S().changePassword,
          onTap: () => context.push(Routes.customerChangePasswordScreen),
        ),
        MenuRow(
          icon: Icons.delete_forever_rounded,
          label: S().deleteAccount,
          danger: true,
          onTap: () => context.push(Routes.customerDeleteAccountScreen),
        ),
      ],
    );
  }
}
