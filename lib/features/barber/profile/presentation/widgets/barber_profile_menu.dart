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
        MenuSection(
          title: S().shopSection,
          children: [
            MenuRow(
              icon: Icons.content_cut_rounded,
              label: S().servicesTitle,
              onTap: () => context.push(Routes.barberServicesScreen),
            ),
            MenuRow(
              icon: Icons.schedule_rounded,
              label: S().workingHoursTitle,
              onTap: () => context.push(Routes.barberHoursScreen),
            ),
            MenuRow(
              icon: Icons.location_on_outlined,
              label: S().locationTitle,
              onTap: () =>
                  context.push(Routes.barberLocationScreen, extra: profile),
            ),
            MenuRow(
              icon: Icons.folder_outlined,
              label: S().myDocuments,
              onTap: () => context.push(Routes.barberDocumentsScreen),
            ),
            MenuRow(
              icon: Icons.receipt_long_outlined,
              label: S().storeOrdersTitle,
              onTap: () => context.push(Routes.barberStoreOrdersScreen),
            ),
            MenuRow(
              icon: Icons.storefront_outlined,
              label: S().storefrontTitle,
              onTap: () => context.push(Routes.barberStorefrontHomeScreen),
            ),
            MenuRow(
              icon: Icons.groups_outlined,
              label: S().teamTitle,
              onTap: () => context.push(Routes.barberTeamScreen),
            ),
            MenuRow(
              icon: Icons.payments_outlined,
              label: S().earningsTitle,
              onTap: () => context.push(Routes.barberEarningsScreen),
            ),
            MenuRow(
              icon: Icons.account_balance_wallet_outlined,
              label: S().walletTitle,
              onTap: () => context.push(Routes.barberWalletScreen),
            ),
            MenuRow(
              icon: Icons.star_border_rounded,
              label: S().reviewsTitle,
              onTap: () => context.push(Routes.barberReviewsScreen),
            ),
            MenuRow(
              icon: Icons.link_rounded,
              label: S().inviteTitle,
              onTap: () => context.push(Routes.barberInviteScreen),
            ),
          ],
        ),
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
