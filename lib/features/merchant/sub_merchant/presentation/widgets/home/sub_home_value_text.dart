import 'package:flutter/material.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../core/theme/styles.dart';
import '../../../../../../core/widgets/custom_text.dart';

class SubHomeValueText extends StatelessWidget {
  final String text;
  final bool muted;

  const SubHomeValueText(this.text, {super.key, this.muted = false});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppText(
      text,
      style: font14w600.copyWith(
        color: muted ? scheme.onSurfaceVariant : scheme.onSurface,
      ),
    );
  }
}
