import '../../../../../generated/l10n.dart';

class SaleMoney {
  const SaleMoney._();

  static String format(double amount) {
    final text = amount == amount.roundToDouble()
        ? amount.toStringAsFixed(0)
        : amount.toStringAsFixed(2);
    return S().currencyEgp(text);
  }
}
