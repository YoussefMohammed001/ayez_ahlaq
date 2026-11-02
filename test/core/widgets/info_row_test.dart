import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/widgets/info_row.dart';

Widget _host(Widget child) => ScreenUtilInit(
  designSize: const Size(402, 874),
  builder: (_, __) => MaterialApp(
    home: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(body: child),
    ),
  ),
);

void main() {
  const phone = '+201522323232';

  testWidgets('a phone value can be forced to render left to right', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        const InfoRow(
          icon: Icons.call_outlined,
          label: 'contact',
          value: phone,
          valueTextDirection: TextDirection.ltr,
        ),
      ),
    );

    final text = tester.widget<Text>(find.text(phone));

    expect(text.textDirection, TextDirection.ltr);
  });

  testWidgets('without an override the value follows the surrounding direction', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        const InfoRow(icon: Icons.store, label: 'shop', value: 'Men Club'),
      ),
    );

    final text = tester.widget<Text>(find.text('Men Club'));

    expect(text.textDirection, isNull);
  });
}
