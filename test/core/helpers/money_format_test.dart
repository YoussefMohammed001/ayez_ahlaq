import 'dart:ui';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:ayez_ahlaq/core/helpers/money_format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() => S.load(const Locale('ar')));

  test('the sign stays inside the isolated number', () {
    expect(
      MoneyFormat.signed(100, positive: false),
      '\u2066-100\u2069 ج',
    );
    expect(
      MoneyFormat.signed(3000, positive: true),
      '\u2066+3000\u2069 ج',
    );
  });

  test('isolated wraps a plain number', () {
    expect(MoneyFormat.isolated(-3000), '\u2066-3000\u2069');
  });
}
