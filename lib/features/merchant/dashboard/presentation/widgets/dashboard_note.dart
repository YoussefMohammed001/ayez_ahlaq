import 'package:flutter/material.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DashboardNote extends StatelessWidget {
  const DashboardNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      S().merchantDashboardNote,
      style: font12w400.copyWith(
        color: context.colorScheme.onSurfaceVariant,
        height: 1.6,
      ),
    );
  }
}
