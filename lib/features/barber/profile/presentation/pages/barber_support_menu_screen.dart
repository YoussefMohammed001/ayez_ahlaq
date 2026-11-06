import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../generated/l10n.dart';
import 'package:ayez_ahlaq/shared/support/presentation/manager/support_cubit.dart';
import 'package:ayez_ahlaq/shared/support/presentation/widgets/whatsapp_menu_row.dart';
import 'package:ayez_ahlaq/shared/support/presentation/widgets/legal_menu_rows.dart';
import 'package:ayez_ahlaq/shared/widgets/profile_menu_section_screen.dart';

class BarberSupportMenuScreen extends StatelessWidget {
  const BarberSupportMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final whatsappRow = WhatsappMenuRow.build(
      context.watch<SupportCubit>().state.info,
    );

    return ProfileMenuSectionScreen(
      title: S().supportSection,
      rows: [
        MenuRow(
          icon: Icons.help_outline_rounded,
          label: S().helpTitle,
          onTap: () => context.push(Routes.barberHelpScreen),
        ),
        MenuRow(
          icon: Icons.info_outline_rounded,
          label: S().aboutApp,
          onTap: () => context.push(Routes.aboutScreen),
        ),
        if (whatsappRow != null) whatsappRow,
        ...LegalMenuRows.build(),
      ],
    );
  }
}
