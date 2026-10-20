import 'package:ayez_ahlaq/features/customer/store/domain/entities/store_cart.dart';
import 'package:ayez_ahlaq/features/customer/store/presentation/widgets/store_cart_summary_card.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

StoreCart cart({required int deliveryFee}) => StoreCart(
  sellerId: 1,
  sellerName: 'shop',
  deliveryOffered: deliveryFee > 0,
  deliveryFee: deliveryFee,
  freeDeliveryOver: null,
  lines: const [],
  itemCount: 2,
  subtotal: 500,
  checkoutReady: true,
);

Future<void> pump(WidgetTester tester, StoreCart cart) {
  tester.view.physicalSize = const Size(1200, 874);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  return tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(1200, 874),
      builder: (_, __) => MaterialApp(
        locale: const Locale('en'),
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: Scaffold(body: StoreCartSummaryCard(cart: cart)),
      ),
    ),
  );
}

void main() {
  testWidgets('a pickup cart never mentions delivery', (tester) async {
    await pump(tester, cart(deliveryFee: 0));

    expect(find.text('Total incl. delivery'), findsNothing);
    expect(find.text('Total'), findsOneWidget);
    expect(find.text('500 EGP'), findsOneWidget);
  });

  testWidgets('a delivery cart shows the fee and the delivery total', (
    tester,
  ) async {
    await pump(tester, cart(deliveryFee: 30));

    expect(find.text('Total incl. delivery'), findsOneWidget);
    expect(find.text('530 EGP'), findsOneWidget);
  });
}
