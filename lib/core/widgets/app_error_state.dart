import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'app_state_view.dart';
import '../../core/extensions/ext_theme.dart';

class AppErrorState extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onRetry;
  final bool compact;

  const AppErrorState({
    super.key,
    this.title,
    this.message,
    this.onRetry,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isOffline = message == S().noInternet ||
        message == S().noInternetConnection;

    return AppStateView(
      icon: isOffline ? Icons.wifi_off_rounded : Icons.error_outline_rounded,
      iconColor: context.semantic.warning,
      title: title ?? S().errorDefaultTitle,
      message: message,
      actionLabel: onRetry == null ? null : S().retry,
      onAction: onRetry,
      compact: compact,
    );
  }
}
