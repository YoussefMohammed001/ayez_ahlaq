import '../../generated/l10n.dart';

class MoneyFormat {
  const MoneyFormat._();

  static String isolated(int value) => '\u2066$value\u2069';

  static String signed(int amount, {required bool positive}) =>
      S().currencyEgp('\u2066${positive ? '+' : '-'}$amount\u2069');
}
