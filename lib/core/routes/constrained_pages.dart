import 'package:go_router/go_router.dart';
import '../responsive/max_content_width.dart';

List<RouteBase> constrainPages(
  List<RouteBase> routes, {
  required Set<String> fullWidthPaths,
}) => [for (final route in routes) _constrain(route, fullWidthPaths)];

RouteBase _constrain(RouteBase route, Set<String> fullWidthPaths) {
  if (route is! GoRoute) return route;

  final builder = route.builder;
  final keepFullWidth = builder == null || fullWidthPaths.contains(route.path);

  return GoRoute(
    path: route.path,
    name: route.name,
    builder: keepFullWidth
        ? builder
        : (context, state) => MaxContentWidth(child: builder(context, state)),
    parentNavigatorKey: route.parentNavigatorKey,
    redirect: route.redirect,
    onExit: route.onExit,
    routes: constrainPages(route.routes, fullWidthPaths: fullWidthPaths),
  );
}
