import 'package:flutter/material.dart';
import 'package:ayez_ahlaq/core/widgets/menu_row.dart';
import 'package:ayez_ahlaq/shared/location/presentation/widgets/location_setting_menu_row.dart';
import 'package:ayez_ahlaq/shared/location/presentation/widgets/location_status_scope.dart';
import 'package:ayez_ahlaq/shared/widgets/profile_menu_section_screen.dart';
import 'package:ayez_ahlaq/shared/widgets/settings/language_sheet.dart';
import 'package:ayez_ahlaq/shared/widgets/settings/theme_sheet.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class CustomerAppSettingsMenuScreen extends StatelessWidget {
  const CustomerAppSettingsMenuScreen({super.key});

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
