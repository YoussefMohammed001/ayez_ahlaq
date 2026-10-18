import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ayez_ahlaq/core/helpers/show_confirm_dialog.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/core/widgets/menu_row.dart';
import 'package:ayez_ahlaq/core/widgets/menu_section.dart';
import 'package:ayez_ahlaq/features/customer/notifications/presentation/widgets/customer_unseen_notifications_badge.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class CustomerProfileMenu extends StatelessWidget {
  final VoidCallback onLogout;

  const CustomerProfileMenu({super.key, required this.onLogout});

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
    return MenuSection(
      title: S().menuTitle,
      children: [
        MenuRow(
          icon: Icons.manage_accounts_outlined,
          label: S().accountManagementSection,
          onTap: () => context.push(Routes.customerAccountMenuScreen),
        ),
        MenuRow(
          icon: Icons.event_note_outlined,
          label: S().bookingsAndServicesSection,
          onTap: () =>
              context.push(Routes.customerBookingsAndServicesMenuScreen),
        ),
        MenuRow(
          icon: Icons.star_border_rounded,
          label: S().reviewsTitle,
          onTap: () => context.push(Routes.customerRatingsScreen),
        ),
        MenuRow(
          icon: Icons.notifications_none_rounded,
          label: S().notifications,
          trailing: const CustomerUnseenNotificationsBadge(),
          onTap: () => context.push(Routes.customerNotificationsScreen),
        ),
        MenuRow(
          icon: Icons.settings_outlined,
          label: S().appSettings,
          onTap: () => context.push(Routes.customerAppSettingsMenuScreen),
        ),
        MenuRow(
          icon: Icons.info_outline_rounded,
          label: S().supportSection,
          onTap: () => context.push(Routes.customerSupportMenuScreen),
        ),
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
