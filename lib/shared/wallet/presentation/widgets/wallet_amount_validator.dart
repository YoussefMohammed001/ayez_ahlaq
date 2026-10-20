import '../../../../generated/l10n.dart';

class WalletAmountValidator {
  const WalletAmountValidator._();

  static String? validate(
    String? input, {
    required bool isWithdraw,
    required int? available,
  }) {
    final text = (input ?? '').trim();
    if (text.isEmpty) return S().walletRequestAmountLabel;

    final amount = int.tryParse(text) ?? 0;
    if (isWithdraw && available != null && amount > available) {
      return S().walletWithdrawExceedsAvailable;
    }
    return null;
  }
}
