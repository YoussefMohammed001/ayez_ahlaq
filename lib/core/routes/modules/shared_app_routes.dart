import 'package:go_router/go_router.dart';
import '../../../shared/widgets/settings/about_app_screen.dart';
import '../../../shared/widgets/success_screen.dart';
import '../../../shared/widgets/success_screen_args.dart';
import '../../../features/splash/presentation/pages/splash_screen.dart';
import '../../../features/user_type/presentation/pages/user_type_screen.dart';
import '../route_paths.dart';

final List<RouteBase> sharedAppRoutes = [
  GoRoute(path: Routes.splashScreen, builder: (_, __) => const SplashScreen()),
  GoRoute(
    path: Routes.userTypeScreen,
    builder: (_, __) => const UserTypeScreen(),
  ),
  GoRoute(
    path: Routes.successScreen,
    builder: (_, state) {
      final args = state.extra as SuccessScreenArgs;
      return SuccessScreen(message: args.message, doneRoute: args.doneRoute);
    },
  ),
  GoRoute(path: Routes.aboutScreen, builder: (_, __) => const AboutAppScreen()),
];
