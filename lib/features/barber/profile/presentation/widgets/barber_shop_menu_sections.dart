import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../core/widgets/menu_section.dart';
import '../../domain/entities/barber_profile.dart';
import '../../../../../generated/l10n.dart';

class BarberShopMenuSections extends StatelessWidget {
  final BarberProfile? profile;

  const BarberShopMenuSections({super.key, this.profile});

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
              icon: Icons.groups_outlined,
              label: S().teamTitle,
              onTap: () => context.push(Routes.barberTeamScreen),
            ),
          ],
        ),
        MenuSection(
          title: S().storeAndSalesSection,
          children: [
            MenuRow(
              icon: Icons.storefront_outlined,
              label: S().storefrontTitle,
              onTap: () => context.push(Routes.barberStorefrontHomeScreen),
            ),
            MenuRow(
              icon: Icons.receipt_long_outlined,
              label: S().storeOrdersTitle,
              onTap: () => context.push(Routes.barberStoreOrdersScreen),
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
          ],
        ),
        MenuSection(
          title: S().moreSection,
          children: [
            MenuRow(
              icon: Icons.star_border_rounded,
              label: S().reviewsTitle,
              onTap: () => context.push(Routes.barberReviewsScreen),
            ),
            // MenuRow(
            //   icon: Icons.link_rounded,
            //   label: S().inviteTitle,
            //   onTap: () => context.push(Routes.barberInviteScreen),
            // ),
          ],
        ),
      ],
    );
  }
}
