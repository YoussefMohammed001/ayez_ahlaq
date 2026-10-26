import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/helpers/user_helpers.dart';
import '../../../../core/notifications/notification_service.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../core/app_startup/update_status.dart';
import '../../../../core/app_startup/version_checker.dart';
import '../../../../core/di/services_locator.dart';
import '../../../../env/env.dart';
import '../../../../shared/analytics/user_analytics_sync.dart';
import '../../../../shared/user_type.dart';
import '../widgets/splash_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  @override
  void initState() {
    super.initState();
    _resolveDestination();
  }

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  Future<void> _resolveDestination() async {
    final versionChecker = sl<VersionChecker>();
    final updateStatus = isProdEnvironment()
        ? versionChecker.fetchStatus()
        : Future.value(UpdateStatus.upToDate);

    final results = await Future.wait([
      UserHelpers.isLoggedIn(),
      _intro
          .forward()
          .orCancel
          .then<bool>((_) => true)
          .catchError((_) => false),
      Future.delayed(const Duration(milliseconds: 1200), () => true),
    ]);

    if (!mounted) return;

    final status = await updateStatus;
    if (!mounted) return;

    await versionChecker.promptIfNeeded(context, status);
    if (!mounted) return;

    if (!UserHelpers.hasSelectedUserType) {
      context.go(Routes.userTypeScreen);
      return;
    }

    final isLoggedIn = results.first;
    if (!isLoggedIn && UserHelpers.userType == UserType.customer) {
      context.go(Routes.customerShell);
      return;
    }

    if (!isLoggedIn) {
      context.go(switch (UserHelpers.userType) {
        UserType.barber => Routes.barberLoginScreen,
        UserType.customer => Routes.customerLoginScreen,
        UserType.merchant => Routes.loginScreen,
      });
      return;
    }

    sl<UserAnalyticsSync>().identify(UserHelpers.userType);

    context.go(switch (UserHelpers.userType) {
      UserType.barber => Routes.barberShell,
      UserType.customer => Routes.customerShell,
      UserType.merchant => Routes.merchantShell,
    });

    sl<NotificationService>().handleLaunchNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      body: SplashBody(
        intro: _intro,
        title: S().appName,
        tagline: S().appTagline,
      ),
    );
  }
}
