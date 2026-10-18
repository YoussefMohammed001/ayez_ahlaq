import 'package:flutter/material.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/location/presentation/widgets/location_setting_menu_row.dart';
import '../../../../../shared/location/presentation/widgets/location_status_scope.dart';
import '../../../../../shared/widgets/settings/language_sheet.dart';
import '../../../../../shared/widgets/settings/theme_sheet.dart';
import 'package:ayez_ahlaq/shared/widgets/profile_menu_section_screen.dart';

class BarberAppSettingsMenuScreen extends StatelessWidget {
  const BarberAppSettingsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LocationStatusScope(
      builder: (context, status) => ProfileMenuSectionScreen(
        title: S().appSettings,
        rows: [
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
          LocationSettingMenuRow.build(context, status),
        ],
      ),
    );
  }
}
