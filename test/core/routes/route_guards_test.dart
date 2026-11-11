import 'package:ayez_ahlaq/core/routes/route_guards.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

GoRouter _router({Object? extra}) => GoRouter(
  initialLocation: '/guarded',
  initialExtra: extra,
  routes: [
    GoRoute(
      path: Routes.splashScreen,
      builder: (_, __) => const Text('splash'),
    ),
    GoRoute(
      path: '/guarded',
      redirect: (_, state) => redirectToSplashUnlessExtraIs<int>(state),
      builder: (_, state) => Text('guarded ${state.extra as int}'),
    ),
  ],
);

void main() {
  testWidgets('goes to splash when the extra is missing', (tester) async {
    await tester.pumpWidget(MaterialApp.router(routerConfig: _router()));
    await tester.pumpAndSettle();

    expect(find.text('splash'), findsOneWidget);
  });

  testWidgets('goes to splash when the extra has the wrong type', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp.router(routerConfig: _router(extra: 'x')),
    );
    await tester.pumpAndSettle();

    expect(find.text('splash'), findsOneWidget);
  });

  testWidgets('stays on the route when the extra has the right type', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp.router(routerConfig: _router(extra: 7)),
    );
    await tester.pumpAndSettle();

    expect(find.text('guarded 7'), findsOneWidget);
  });
}
