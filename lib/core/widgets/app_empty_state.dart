import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'app_state_view.dart';
import '../../core/extensions/ext_theme.dart';

class AppEmptyState extends StatelessWidget {
  final String? title;
  final String? message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool compact;

  const AppEmptyState({
    super.key,
    this.title,
    this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppStateView(
      icon: icon,
      iconColor: context.colorScheme.onSurfaceVariant,
      title: title ?? S().emptyDefaultTitle,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      compact: compact,
    );
  }
}
