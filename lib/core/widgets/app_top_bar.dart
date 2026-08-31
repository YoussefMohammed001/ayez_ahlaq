import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../theme/heading_styles.dart';
import '../../core/extensions/ext_theme.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? trailing;

  const AppTopBar({super.key, required this.title, this.trailing});

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: context.colorScheme.onSurface,
        ),
        onPressed: () => context.pop(),
      ),
      title: Text(title, style: HeadingStyles.h4),
      actions: trailing == null ? null : [trailing!, SizedBox(width: 8.w)],
    );
  }
}
