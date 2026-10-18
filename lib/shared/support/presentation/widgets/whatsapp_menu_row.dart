import 'package:flutter/material.dart';
import '../../../../core/helpers/external_url_launcher.dart';
import '../../../../core/widgets/menu_row.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/support_info.dart';

class WhatsappMenuRow {
  const WhatsappMenuRow._();

  static MenuRow? build(SupportInfo? info) {
    if (!(info?.hasWhatsapp ?? false)) return null;

    return MenuRow(
      icon: Icons.chat_outlined,
      label: S().whatsappSupport,
      onTap: () => ExternalUrlLauncher.open(
        info!.whatsappUrl!,
        errorMessage: S().whatsapp_error,
      ),
    );
  }
}
