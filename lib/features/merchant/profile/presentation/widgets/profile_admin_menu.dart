import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../shared/widgets/settings/language_sheet.dart';
import '../../../../../shared/widgets/settings/theme_sheet.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../core/widgets/menu_section.dart';
import '../../domain/entities/merchant_profile.dart';
import '../../../documents/presentation/widgets/missing_documents_badge.dart';
import '../../../notifications/presentation/widgets/unseen_notifications_badge.dart';
import '../../../../../generated/l10n.dart';

class ProfileAdminMenu extends StatelessWidget {
  final MerchantProfile? profile;
  final VoidCallback onLogout;

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

    if (confirmed) onLogout();
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
    return [
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
    ];
  }
}
