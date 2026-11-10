import 'package:flutter/material.dart';
import '../../core/helpers/alerts.dart';
import '../../core/helpers/show_confirm_dialog.dart';
import '../../core/widgets/menu_row.dart';
import '../../generated/l10n.dart';

class LogoutMenuRow {
  const LogoutMenuRow._();

  static MenuRow row(
    BuildContext context,
    Future<void> Function() onLogout,
  ) {
    return MenuRow(
      icon: Icons.logout_rounded,
      label: S().logout,
      danger: true,
      showChevron: false,
      onTap: () => _confirm(context, onLogout),
    );
  }

  static Future<void> _confirm(
    BuildContext context,
    Future<void> Function() onLogout,
  ) async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().logoutTitle,
      message: S().logoutConfirm,
      confirmLabel: S().logoutTitle,
      icon: Icons.logout_rounded,
    );

    if (!confirmed) return;

    await showLoading();
    try {
      await onLogout();
    } finally {
      hideLoading();
    }
  }
}
