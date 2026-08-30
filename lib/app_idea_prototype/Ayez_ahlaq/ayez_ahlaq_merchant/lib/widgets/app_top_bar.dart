import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Standard "back + title" header used on every flow screen (as opposed to
/// the five bottom-nav tab screens, which have no back button).
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? trailing;

  const AppTopBar({super.key, required this.title, this.trailing});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_forward, color: AppColors.ivory100),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      title: Text(title, style: AppTextStyles.headingH3),
      actions: trailing == null ? null : [trailing!, const SizedBox(width: 8)],
    );
  }
}

/// A slim context strip shown under the top bar during the booking flow,
/// e.g. "بتحجز في صالون الملك".
class ContextBar extends StatelessWidget {
  final String text;
  const ContextBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.ink800,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Text(text, style: AppTextStyles.bodySmall.copyWith(color: AppColors.ivory300)),
    );
  }
}
