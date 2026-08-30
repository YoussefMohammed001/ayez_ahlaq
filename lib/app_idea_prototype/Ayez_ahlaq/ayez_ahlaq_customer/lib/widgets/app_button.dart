import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum AppButtonStyle { primary, secondary, dark, ghost }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonStyle style;
  final Widget? icon;
  final bool expand;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.style = AppButtonStyle.primary,
    this.icon,
    this.expand = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Color fg;
    BoxBorder? border;
    switch (style) {
      case AppButtonStyle.primary:
        bg = AppColors.brass500;
        fg = AppColors.ink950;
        break;
      case AppButtonStyle.secondary:
        bg = AppColors.ink800;
        fg = AppColors.ivory100;
        border = Border.all(color: AppColors.hairline);
        break;
      case AppButtonStyle.dark:
        bg = AppColors.ink700;
        fg = AppColors.ivory100;
        border = Border.all(color: AppColors.hairline);
        break;
      case AppButtonStyle.ghost:
        bg = Colors.transparent;
        fg = AppColors.rust400;
        border = Border.all(color: AppColors.hairline);
        break;
    }

    final disabled = onPressed == null;

    final child = Container(
      width: expand ? double.infinity : null,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
      decoration: BoxDecoration(
        color: disabled ? bg.withOpacity(0.4) : bg,
        borderRadius: BorderRadius.circular(14),
        border: border,
      ),
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[icon!, const SizedBox(width: 8)],
          Text(label, style: AppTextStyles.labelButton.copyWith(color: fg)),
        ],
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onPressed,
        child: child,
      ),
    );
  }
}
