import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../core/widgets/menu_section.dart';
import '../../../../../shared/widgets/settings/language_sheet.dart';
import '../../../../../shared/widgets/settings/theme_sheet.dart';
import '../../../notifications/presentation/widgets/unseen_notifications_badge.dart';
import '../../domain/entities/barber_profile.dart';
import '../../../../../generated/l10n.dart';
import 'barber_shop_menu_sections.dart';

class BarberProfileMenu extends StatelessWidget {
  final BarberProfile? profile;
  final VoidCallback onLogout;

  const BarberProfileMenu({super.key, this.profile, required this.onLogout});

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
    return Column(
      children: [
        BarberShopMenuSections(profile: profile),
        MenuSection(
          title: S().appSettings,
          children: [
            MenuRow(
              icon: Icons.notifications_none_rounded,
              label: S().notifications,
              trailing: const BarberUnseenNotificationsBadge(),
              onTap: () => context.push(Routes.barberNotificationsScreen),
            ),
            MenuRow(
              icon: Icons.brightness_6_rounded,
              label: S().theme,
              onTap: () => ThemeSheet.show(context),
            ),
            MenuRow(
              icon: Icons.language_rounded,
              label: S().language,
              onTap: () => LanguageSheet.show(context),
            ),
            MenuRow(
              icon: Icons.lock_outline_rounded,
              label: S().changePassword,
              onTap: () => context.push(Routes.barberChangePasswordScreen),
            ),
          ],
        ),
        MenuSection(
          title: S().supportSection,
          children: [
            MenuRow(
              icon: Icons.info_outline_rounded,
              label: S().aboutApp,
              onTap: () => context.push(Routes.aboutScreen),
            ),
            MenuRow(
              icon: Icons.logout_rounded,
              label: S().logout,
              danger: true,
              showChevron: false,
              onTap: () => _confirmLogout(context),
            ),
          ],
        ),
      ],
    );
  }
}
