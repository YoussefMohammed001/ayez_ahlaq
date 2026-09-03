import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/helpers/user_helpers.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/extensions/ext_theme.dart';
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
    final results = await Future.wait([
      UserHelpers.isLoggedIn(),
      _intro.forward().orCancel.then<bool>((_) => true).catchError((_) => false),
      Future.delayed(const Duration(milliseconds: 1200), () => true),
    ]);

    if (!mounted) return;

    if (!UserHelpers.hasSelectedUserType) {
      context.go(Routes.userTypeScreen);
      return;
    }

    final isLoggedIn = results.first;
    if (!isLoggedIn) {
      context.go(
        UserHelpers.userType == UserType.barber
            ? Routes.barberLoginScreen
            : Routes.loginScreen,
      );
      return;
    }

    context.go(
      UserHelpers.userType == UserType.barber
          ? Routes.barberShell
          : Routes.merchantShell,
    );
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
