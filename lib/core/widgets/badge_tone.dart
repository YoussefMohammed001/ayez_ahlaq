import 'package:flutter/material.dart';
import '../extensions/ext_theme.dart';

enum BadgeTone {
  open,
  closed,
  gold,
  danger,
  muted,
  info;

  Color foreground(BuildContext context) => switch (this) {
    BadgeTone.open => context.semantic.success,
    BadgeTone.closed => context.semantic.warning,
    BadgeTone.gold => context.semantic.accentSoft,
    BadgeTone.danger => context.semantic.warning,
    BadgeTone.muted => context.colorScheme.onSurfaceVariant,
    BadgeTone.info => context.semantic.info,
  };

  Color background(BuildContext context) =>
      foreground(context).withValues(alpha: 0.16);
}
