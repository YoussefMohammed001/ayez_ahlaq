import 'package:flutter/material.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/external_url_launcher.dart';
import '../../../../core/widgets/menu_row.dart';
import '../../../../generated/l10n.dart';

class LegalMenuRows {
  const LegalMenuRows._();

  static List<MenuRow> build() {
    return [
      _row(Icons.privacy_tip_outlined, S().privacyPolicy, AppStrings.privacyPolicyUrl),
      _row(Icons.description_outlined, S().termsAndConditions, AppStrings.termsUrl),
    ];
  }

  static MenuRow _row(IconData icon, String label, String url) {
    return MenuRow(
      icon: icon,
      label: label,
      onTap: () => ExternalUrlLauncher.open(url, errorMessage: S().linkOpenError),
    );
  }
}
