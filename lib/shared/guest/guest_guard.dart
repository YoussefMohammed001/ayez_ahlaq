import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/helpers/user_helpers.dart';
import '../../core/routes/route_paths.dart';
import '../../core/widgets/app_confirm_dialog.dart';
import '../../generated/l10n.dart';

class GuestGuard {
  const GuestGuard._();

  static Future<bool> ensureLoggedIn(BuildContext context) async {
    if (!await UserHelpers.isGuest()) return true;
    if (!context.mounted) return false;

    final wantsToSignIn = await showDialog<bool>(
      context: context,
      builder: (_) => AppConfirmDialog(
        title: S().guestLoginTitle,
        message: S().guestLoginMessage,
        confirmLabel: S().signIn,
        icon: Icons.lock_outline_rounded,
        isDestructive: false,
      ),
    );

    if (wantsToSignIn == true && context.mounted) {
      context.push(Routes.customerLoginScreen);
    }
    return false;
  }

  static Future<void> run(BuildContext context, VoidCallback action) async {
    if (await ensureLoggedIn(context)) action();
  }
}
