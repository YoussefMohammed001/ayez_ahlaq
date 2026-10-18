import 'package:ayez_ahlaq/core/helpers/alerts.dart';
import 'package:ayez_ahlaq/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpHost(WidgetTester tester) {
  return tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(402, 874),
      builder: (_, __) => MaterialApp(
        navigatorKey: rootNavigatorKey,
        home: const Scaffold(body: Text('home')),
      ),
    ),
  );
}

void main() {
  testWidgets('shows a spinner and removes only the spinner', (tester) async {
    await pumpHost(tester);

    final shown = showLoading();
    await tester.pump();
    await shown;
    await tester.pump();
    expect(find.byType(SpinKitDualRing), findsOneWidget);

    hideLoading();
    await tester.pumpAndSettle();
    expect(find.byType(SpinKitDualRing), findsNothing);
    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('hiding before the first frame never pops the page', (
    tester,
  ) async {
    await pumpHost(tester);

    final shown = showLoading();
    hideLoading();
    await tester.pump();
    await shown;
    await tester.pumpAndSettle();

    expect(find.byType(SpinKitDualRing), findsNothing);
    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('can be shown again after being hidden', (tester) async {
    await pumpHost(tester);

    hideLoading();
    final shown = showLoading();
    await tester.pump();
    await shown;
    await tester.pump();

    expect(find.byType(SpinKitDualRing), findsOneWidget);
    hideLoading();
    await tester.pumpAndSettle();
  });
}
