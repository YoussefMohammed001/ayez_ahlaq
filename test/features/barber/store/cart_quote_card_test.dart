import 'package:ayez_ahlaq/features/barber/store/domain/entities/store_quote.dart';
import 'package:ayez_ahlaq/features/barber/store/presentation/widgets/cart_quote_card.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

StoreQuote quote({required int deliveryFee}) => StoreQuote(
  lines: const [],
  subtotal: 515,
  orderDiscount: 0,
  total: 515,
  deliveryFee: deliveryFee,
  grandTotal: 515 + deliveryFee,
  grossSubtotal: 720,
  discountTotal: 205,
);

Future<void> pump(WidgetTester tester, StoreQuote quote) {
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
        home: Scaffold(body: CartQuoteCard(quote: quote)),
      ),
    ),
  );
}

void main() {
  testWidgets('a pickup quote shows one plain total and no delivery wording', (
    tester,
  ) async {
    await pump(tester, quote(deliveryFee: 0));

    expect(find.text('Total incl. delivery'), findsNothing);
    expect(find.text('Total'), findsOneWidget);
    expect(find.text('515 EGP'), findsOneWidget);
  });

  testWidgets('a delivery quote shows the fee and the delivery total', (
    tester,
  ) async {
    await pump(tester, quote(deliveryFee: 30));

    expect(find.text('Total incl. delivery'), findsOneWidget);
    expect(find.text('545 EGP'), findsOneWidget);
  });
}
