import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/helpers/user_helpers.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/theme/heading_styles.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/extensions/ext_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _resolveDestination();
  }

  Future<void> _resolveDestination() async {
    await Future.delayed(const Duration(milliseconds: 900));

    final loggedIn = await UserHelpers.isLoggedIn();

    if (!mounted) return;

    if (!UserHelpers.hasSelectedUserType) {
      context.go(Routes.userTypeScreen);
      return;
    }

    context.go(loggedIn ? Routes.merchantShell : Routes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.content_cut_rounded,
              size: 56.r,
              color: context.colorScheme.primary,
            ),
            SizedBox(height: 16.h),
            Text(S().appName, style: HeadingStyles.h1),
          ],
        ),
      ),
    );
  }
}
