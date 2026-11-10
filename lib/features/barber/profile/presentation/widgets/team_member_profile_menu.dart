import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../core/widgets/menu_section.dart';
import '../../../../../generated/l10n.dart';
import '../../../notifications/presentation/widgets/unseen_notifications_badge.dart';
import '../../domain/entities/barber_profile.dart';
import '../../../../../shared/widgets/logout_menu_row.dart';

class TeamMemberProfileMenu extends StatelessWidget {
  final BarberProfile? profile;
  final Future<void> Function() onLogout;

  const TeamMemberProfileMenu({super.key, this.profile, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return MenuSection(
      title: S().menuTitle,
      children: [
        MenuRow(
          icon: Icons.badge_outlined,
          label: S().profileDetailsTitle,
          onTap: () => context.push(Routes.barberProfileDetailsScreen),
        ),
        MenuRow(
          icon: Icons.lock_outline_rounded,
          label: S().changePassword,
          onTap: () => context.push(Routes.barberChangePasswordScreen),
        ),
        if (profile?.canViewRevenue ?? false)
          MenuRow(
            icon: Icons.payments_outlined,
            label: S().earningsTitle,
            onTap: () => context.push(Routes.barberEarningsScreen),
          ),
        MenuRow(
          icon: Icons.groups_outlined,
          label: S().teamTitle,
          onTap: () => context.push(Routes.barberTeamScreen),
        ),
        MenuRow(
          icon: Icons.star_border_rounded,
          label: S().reviewsTitle,
          onTap: () => context.push(Routes.barberReviewsScreen),
        ),
        MenuRow(
          icon: Icons.notifications_none_rounded,
          label: S().notifications,
          trailing: const BarberUnseenNotificationsBadge(),
          onTap: () => context.push(Routes.barberNotificationsScreen),
        ),
        MenuRow(
          icon: Icons.settings_outlined,
          label: S().appSettings,
          onTap: () => context.push(Routes.barberAppSettingsMenuScreen),
        ),
        MenuRow(
          icon: Icons.info_outline_rounded,
          label: S().supportSection,
          onTap: () => context.push(Routes.barberSupportMenuScreen),
        ),
        LogoutMenuRow.row(context, onLogout),
      ],
    );
  }
}
