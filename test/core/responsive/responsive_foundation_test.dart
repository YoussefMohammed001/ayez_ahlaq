import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ayez_ahlaq/core/responsive/adaptive_nav_scaffold.dart';
import 'package:ayez_ahlaq/core/responsive/max_content_width.dart';
import 'package:ayez_ahlaq/core/responsive/responsive_scale.dart';
import 'package:ayez_ahlaq/core/responsive/window_size.dart';
import 'package:ayez_ahlaq/core/routes/constrained_pages.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/core/widgets/nav_tab_item.dart';

Widget _app(Widget home, Size size) => MediaQuery(
  data: MediaQueryData(size: size),
  child: ScreenUtilInit(
    designSize: ResponsiveScale.designSizeFor(size),
    builder: (_, __) => MaterialApp(theme: lightTheme, home: home),
  ),
);

void main() {
  group('window size', () {
    test('follows the Material breakpoints', () {
      expect(WindowSize.ofWidth(390), WindowSize.compact);
      expect(WindowSize.ofWidth(599), WindowSize.compact);
      expect(WindowSize.ofWidth(600), WindowSize.medium);
      expect(WindowSize.ofWidth(839), WindowSize.medium);
      expect(WindowSize.ofWidth(840), WindowSize.expanded);
      expect(WindowSize.ofWidth(1366), WindowSize.expanded);
    });

    test('tells phones from tablets', () {
      expect(WindowSize.compact.isTablet, isFalse);
      expect(WindowSize.medium.isTablet, isTrue);
      expect(WindowSize.expanded.isExpanded, isTrue);
    });
  });

  group('scale', () {
    test('phones keep the original design size', () {
      expect(
        ResponsiveScale.designSizeFor(const Size(390, 844)),
        const Size(402, 874),
      );
      expect(
        ResponsiveScale.designSizeFor(const Size(430, 932)),
        const Size(402, 874),
      );
    });

    test('tablets scale by a small fixed factor, whatever the size', () {
      for (final size in const [
        Size(820, 1180),
        Size(1024, 1366),
        Size(1366, 1024),
      ]) {
        final design = ResponsiveScale.designSizeFor(size);

        expect(
          size.width / design.width,
          closeTo(ResponsiveScale.tabletScale, 1e-9),
        );
        expect(
          size.height / design.height,
          closeTo(ResponsiveScale.tabletScale, 1e-9),
        );
      }
    });
  });

  group('pages', () {
    testWidgets('are capped to a readable width and centered', (tester) async {
      tester.view.physicalSize = const Size(1640, 2360);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          theme: lightTheme,
          home: const MaxContentWidth(child: SizedBox.expand(key: Key('page'))),
        ),
      );

      expect(
        tester.getSize(find.byKey(const Key('page'))).width,
        MaxContentWidth.pageWidth,
      );
      expect(tester.getCenter(find.byKey(const Key('page'))).dx, 410);
    });

    test('route wrapping keeps paths, names, children and redirects', () {
      final original = [
        GoRoute(
          path: '/a',
          name: 'a',
          builder: (_, __) => const SizedBox(),
          routes: [GoRoute(path: 'b', builder: (_, __) => const SizedBox())],
        ),
        GoRoute(path: '/old', redirect: (_, __) => '/a'),
        GoRoute(path: '/shell', builder: (_, __) => const SizedBox()),
      ];

      final wrapped = constrainPages(original, fullWidthPaths: {'/shell'});

      expect(wrapped, hasLength(3));
      final a = wrapped[0] as GoRoute;
      expect(a.path, '/a');
      expect(a.name, 'a');
      expect((a.routes.single as GoRoute).path, 'b');
      expect((wrapped[1] as GoRoute).builder, isNull);
      expect((wrapped[1] as GoRoute).redirect, isNotNull);
      expect(
        identical(
          (wrapped[2] as GoRoute).builder,
          (original[2] as GoRoute).builder,
        ),
        isTrue,
      );
    });
  });

  group('navigation', () {
    final items = [
      const NavTabItem(Icons.home_rounded, 'الرئيسية'),
      const NavTabItem(Icons.person_rounded, 'حسابي'),
    ];

    Widget scaffold(Size size, ValueChanged<int> onTap) => _app(
      AdaptiveNavScaffold(
        items: items,
        currentIndex: 0,
        onTap: onTap,
        body: const Text('المحتوى'),
        compactBottomBar: const SizedBox(key: Key('bottom'), height: 40),
      ),
      size,
    );

    testWidgets('a phone keeps the bottom bar', (tester) async {
      tester.view.physicalSize = const Size(780, 1688);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(scaffold(const Size(390, 844), (_) {}));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('bottom')), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);
    });

    testWidgets('a tablet gets a side rail that switches tabs', (tester) async {
      tester.view.physicalSize = const Size(1640, 2360);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      int? tapped;

      await tester.pumpWidget(
        scaffold(const Size(820, 1180), (i) => tapped = i),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('bottom')), findsNothing);
      expect(find.byType(NavigationRail), findsOneWidget);

      await tester.tap(find.text('حسابي'));
      expect(tapped, 1);
    });

    testWidgets(
      'a wide tablet shows the rail expanded with labels beside icons',
      (tester) async {
        tester.view.physicalSize = const Size(2732, 2048);
        tester.view.devicePixelRatio = 2;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(scaffold(const Size(1366, 1024), (_) {}));
        await tester.pumpAndSettle();

        expect(
          tester.widget<NavigationRail>(find.byType(NavigationRail)).extended,
          isTrue,
        );
      },
    );
  });
}
