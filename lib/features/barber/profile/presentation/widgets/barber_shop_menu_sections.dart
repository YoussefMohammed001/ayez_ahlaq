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
              icon: Icons.local_cafe_outlined,
              label: S().drinksTitle,
              onTap: () => context.push(Routes.barberDrinksScreen),
            ),
          ],
        ),
        MenuSection(
          title: S().purchasesSection,
          children: [
            MenuRow(
              icon: Icons.storefront_outlined,
              label: S().storeTitle,
              onTap: () => context.push(Routes.barberStoreMerchantsScreen),
            ),
          ],
        ),
        MenuSection(
          title: S().financialSection,
          children: [
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
              icon: Icons.workspace_premium_outlined,
              label: S().subscriptionTitle,
              onTap: () => context.push(Routes.barberSubscriptionScreen),
            ),
            MenuRow(
              icon: Icons.trending_up_rounded,
              label: S().sponsorshipTitle,
              onTap: () => context.push(Routes.barberSponsorshipScreen),
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
            MenuRow(
              icon: Icons.campaign_outlined,
              label: S().sendBroadcast,
              onTap: () => context.push(Routes.barberBroadcastListScreen),
            ),
          ],
        ),
      ],
    );
  }
}
