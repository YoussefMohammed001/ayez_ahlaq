import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../theme/heading_styles.dart';
import '../../core/extensions/ext_theme.dart';
import '../helpers/user_helpers.dart';
import '../routes/merchant_home_route.dart';
import '../routes/route_paths.dart';
import '../../shared/user_type.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? trailing;
  final bool viewLeading;
  final PreferredSizeWidget? bottom;

  const AppTopBar({super.key, required this.title, this.trailing,
  this.viewLeading = true,
  this.bottom,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.h + (bottom?.preferredSize.height ?? 0));

  String get _homeShellRoute => switch (UserHelpers.userType) {
    UserType.customer => Routes.customerShell,
    UserType.barber => Routes.barberShell,
    UserType.merchant => merchantHomeRoute,
  };

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:
      viewLeading ?
      IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: context.colorScheme.onSurface,
        ),
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(_homeShellRoute);
          }
        },
      ) : SizedBox(),
      title: Text(title, style: HeadingStyles.h4),
      actions: trailing == null ? null : [trailing!, SizedBox(width: 8.w)],
      bottom: bottom,
    );
  }
}
