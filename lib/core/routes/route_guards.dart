import 'package:go_router/go_router.dart';
import 'route_paths.dart';

String? redirectToSplashUnlessExtraIs<T>(GoRouterState state) {
  return state.extra is T ? null : Routes.splashScreen;
}
