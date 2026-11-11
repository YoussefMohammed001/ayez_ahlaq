import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../core/widgets/menu_section.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/logout_menu_row.dart';
import '../../../../../shared/widgets/settings/language_sheet.dart';
import '../../../../../shared/widgets/settings/theme_sheet.dart';
import '../../../notifications/presentation/widgets/unseen_notifications_badge.dart';

class SubMerchantMenu extends StatelessWidget {
  final Future<void> Function() onLogout;

  const SubMerchantMenu({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuSection(
          title: S().accountSection,
          children: [
            MenuRow(
              icon: Icons.lock_outline_rounded,
              label: S().changePassword,
              onTap: () => context.push(Routes.memberChangePasswordScreen),
            ),
          ],
        ),
        MenuSection(
          title: S().appSettings,
          children: [
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
            LogoutMenuRow.row(context, onLogout),
          ],
        ),
      ],
    );
  }
}
