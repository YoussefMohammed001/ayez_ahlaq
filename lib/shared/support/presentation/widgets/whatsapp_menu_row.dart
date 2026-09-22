import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/helpers/alerts.dart';
import '../../../../core/widgets/menu_row.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/support_info.dart';

class WhatsappMenuRow {
  const WhatsappMenuRow._();

  static Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      showError(S().whatsapp_error);
    }
  }

  static MenuRow? build(SupportInfo? info) {
    if (!(info?.hasWhatsapp ?? false)) return null;

    return MenuRow(
      icon: Icons.chat_outlined,
      label: S().whatsappSupport,
      onTap: () => _launch(info!.whatsappUrl!),
    );
  }
}
