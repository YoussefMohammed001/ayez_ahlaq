import 'package:flutter/material.dart';
import 'package:ayez_ahlaq/core/theme/styles.dart';

class SwitchRow extends StatelessWidget {
  final String label;
  final bool value;
  final ColorScheme cs;
  final ValueChanged<bool> onChanged;

  const SwitchRow({
    super.key,
    required this.label,
    required this.value,
    required this.cs,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: font12w600.copyWith(color: cs.onSurface)),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: cs.primary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }
}
