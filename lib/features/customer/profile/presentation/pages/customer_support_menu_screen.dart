import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ayez_ahlaq/core/helpers/show_confirm_dialog.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/core/widgets/menu_row.dart';
import 'package:ayez_ahlaq/shared/support/presentation/manager/support_cubit.dart';
import 'package:ayez_ahlaq/shared/support/presentation/widgets/whatsapp_menu_row.dart';
import 'package:ayez_ahlaq/shared/widgets/profile_menu_section_screen.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class CustomerSupportMenuScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const CustomerSupportMenuScreen({super.key, required this.onLogout});

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().logoutTitle,
      message: S().logoutConfirm,
      confirmLabel: S().logoutTitle,
      icon: Icons.logout_rounded,
    );

    if (confirmed) onLogout();
  }

  @override
  Widget build(BuildContext context) {
    final whatsappRow = WhatsappMenuRow.build(
      context.watch<SupportCubit>().state.info,
    );

    return ProfileMenuSectionScreen(
      title: S().supportSection,
      rows: [
        MenuRow(
          icon: Icons.info_outline_rounded,
          label: S().aboutApp,
          onTap: () => context.push(Routes.aboutScreen),
        ),
        if (whatsappRow != null) whatsappRow,
        MenuRow(
          icon: Icons.logout_rounded,
          label: S().logout,
          danger: true,
          showChevron: false,
          onTap: () => _confirmLogout(context),
        ),
      ],
    );
  }
}
