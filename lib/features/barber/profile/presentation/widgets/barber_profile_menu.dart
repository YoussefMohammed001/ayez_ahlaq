import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../core/widgets/menu_section.dart';
import '../../../notifications/presentation/widgets/unseen_notifications_badge.dart';
import '../../../documents/presentation/widgets/missing_documents_badge.dart';
import '../../domain/entities/barber_profile.dart';
import 'barber_logout.dart';
import '../../../../../generated/l10n.dart';

class BarberProfileMenu extends StatelessWidget {
  final BarberProfile? profile;
  final Future<void> Function() onLogout;

  const BarberProfileMenu({super.key, this.profile, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return MenuSection(
      title: S().menuTitle,
      children: [
        MenuRow(
          icon: Icons.manage_accounts_outlined,
          label: S().accountManagementSection,
          onTap: () => context.push(Routes.barberAccountMenuScreen),
        ),
        MenuRow(
          icon: Icons.storefront_outlined,
          label: S().shopSection,
          trailing: const MissingDocumentsBadge(),
          onTap: () =>
              context.push(Routes.barberShopMenuScreen, extra: profile),
        ),
        MenuRow(
          icon: Icons.point_of_sale_outlined,
          label: S().storeAndSalesSection,
          onTap: () => context.push(Routes.barberStoreAndSalesMenuScreen),
        ),
        MenuRow(
          icon: Icons.shopping_bag_outlined,
          label: S().purchasesSection,
          onTap: () => context.push(Routes.barberPurchasesMenuScreen),
        ),
        MenuRow(
          icon: Icons.account_balance_outlined,
          label: S().financialSection,
          onTap: () => context.push(Routes.barberFinancialMenuScreen),
        ),
        MenuRow(
          icon: Icons.star_border_rounded,
          label: S().reviewsTitle,
          onTap: () => context.push(Routes.barberReviewsScreen),
        ),
        MenuRow(
          icon: Icons.campaign_outlined,
          label: S().sendBroadcast,
          onTap: () => context.push(Routes.barberBroadcastListScreen),
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
        BarberLogout.row(context, onLogout),
      ],
    );
  }
}
