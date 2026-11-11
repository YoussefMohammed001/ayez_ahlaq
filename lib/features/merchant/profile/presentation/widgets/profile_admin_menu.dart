import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../shared/widgets/settings/language_sheet.dart';
import '../../../../../shared/widgets/settings/theme_sheet.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../core/widgets/menu_section.dart';
import '../../domain/entities/merchant_profile.dart';
import '../../../documents/presentation/widgets/missing_documents_badge.dart';
import '../../../notifications/presentation/widgets/unseen_notifications_badge.dart';
import '../../../../../shared/support/presentation/manager/support_cubit.dart';
import '../../../../../shared/support/presentation/widgets/whatsapp_menu_row.dart';
import 'package:ayez_ahlaq/shared/support/presentation/widgets/legal_menu_rows.dart';
import '../../../../../generated/l10n.dart';

class ProfileAdminMenu extends StatelessWidget {
  final MerchantProfile? profile;
  final Future<void> Function() onLogout;

  const ProfileAdminMenu({
    super.key,
    required this.profile,
    required this.onLogout,
  });

  Future<void> _confirmLogout(BuildContext context) async {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuSection(
          title: S().management,
          children: _buildBusinessRows(context),
        ),
        MenuSection(
          title: S().accountSection,
          children: _buildAccountRows(context),
        ),
        MenuSection(
          title: S().appSettings,
          children: _buildSettingsRows(context),
        ),
        MenuSection(
          title: S().supportSection,
          children: _buildSupportRows(context),
        ),
      ],
    );
  }

  List<MenuRow> _buildBusinessRows(BuildContext context) {
    return [
      MenuRow(
        icon: Icons.people_outline_rounded,
        label: S().myCustomers,
        onTap: () => context.push(Routes.merchantCustomersScreen),
      ),
      MenuRow(
        icon: Icons.point_of_sale_rounded,
        label: S().salesTitle,
        onTap: () => context.push(Routes.merchantSalesScreen),
      ),
      MenuRow(
        icon: Icons.groups_2_outlined,
        label: S().teamTitle,
        onTap: () => context.push(Routes.merchantTeamScreen),
      ),
      MenuRow(
        icon: Icons.local_offer_outlined,
        label: S().discountsTitle,
        onTap: () => context.push(Routes.merchantDiscountsScreen),
      ),
      MenuRow(
        icon: Icons.category_outlined,
        label: S().myCategories,
        onTap: () => context.push(
          Routes.merchantCategoriesScreen,
          extra: profile?.categoryLimit ?? 0,
        ),
      ),
      MenuRow(
        icon: Icons.delivery_dining_outlined,
        label: S().deliveryTitle,
        onTap: () => context.push(Routes.merchantDeliveryScreen),
      ),
      MenuRow(
        icon: Icons.location_on_outlined,
        label: S().locationTitle,
        onTap: () =>
            context.push(Routes.merchantLocationScreen, extra: profile),
      ),
      MenuRow(
        icon: Icons.workspace_premium_outlined,
        label: S().subscriptionTitle,
        onTap: () => context.push(Routes.merchantSubscriptionScreen),
      ),
      MenuRow(
        icon: Icons.trending_up_rounded,
        label: S().sponsorshipTitle,
        onTap: () => context.push(Routes.merchantSponsorshipScreen),
      ),
      MenuRow(
        icon: Icons.account_balance_wallet_outlined,
        label: S().walletTitle,
        onTap: () => context.push(Routes.merchantWalletScreen),
      ),
      MenuRow(
        icon: Icons.campaign_outlined,
        label: S().sendBroadcast,
        onTap: () =>
            context.push(Routes.merchantBroadcastListScreen, extra: profile),
      ),
    ];
  }

  List<MenuRow> _buildAccountRows(BuildContext context) {
    return [
      if (profile != null)
        MenuRow(
          icon: Icons.edit_outlined,
          label: S().editMyInfo,
          onTap: () =>
              context.push(Routes.merchantEditProfileScreen, extra: profile),
        ),
      MenuRow(
        icon: Icons.call_outlined,
        label: S().extraPhones,
        onTap: () => context.push(Routes.merchantPhonesScreen),
      ),
      MenuRow(
        icon: Icons.folder_outlined,
        label: S().myDocuments,
        trailing: const MissingDocumentsBadge(),
        onTap: () => context.push(Routes.merchantDocumentsScreen),
      ),
      MenuRow(
        icon: Icons.lock_outline_rounded,
        label: S().changePassword,
        onTap: () => context.push(Routes.merchantChangePasswordScreen),
      ),
      MenuRow(
        icon: Icons.delete_forever_rounded,
        label: S().deleteAccount,
        danger: true,
        onTap: () => context.push(Routes.merchantDeleteAccountScreen),
      ),
    ];
  }

  List<MenuRow> _buildSettingsRows(BuildContext context) {
    return [
      MenuRow(
        icon: Icons.notifications_none_rounded,
        label: S().notifications,
        trailing: const UnseenNotificationsBadge(),
        onTap: () => context.push(Routes.merchantNotificationsScreen),
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
    ];
  }

  List<MenuRow> _buildSupportRows(BuildContext context) {
    final whatsappRow = WhatsappMenuRow.build(
      context.watch<SupportCubit>().state.info,
    );

    return [
      MenuRow(
        icon: Icons.info_outline_rounded,
        label: S().aboutApp,
        onTap: () => context.push(Routes.aboutScreen),
      ),
      if (whatsappRow != null) whatsappRow,
      ...LegalMenuRows.build(),
      MenuRow(
        icon: Icons.logout_rounded,
        label: S().logout,
        danger: true,
        showChevron: false,
        onTap: () => _confirmLogout(context),
      ),
    ];
  }
}
