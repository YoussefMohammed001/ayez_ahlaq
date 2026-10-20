import 'package:ayez_ahlaq/shared/wallet/presentation/widgets/wallet_amount_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('rejects an empty amount', () {
    expect(
      WalletAmountValidator.validate('', isWithdraw: true, available: 500),
      isNotNull,
    );
  });

  test('a withdraw above the available balance is rejected', () {
    expect(
      WalletAmountValidator.validate('501', isWithdraw: true, available: 500),
      isNotNull,
    );
  });

  test('a withdraw up to the available balance is accepted', () {
    expect(
      WalletAmountValidator.validate('500', isWithdraw: true, available: 500),
      isNull,
    );
  });

  test('a deposit is never limited by the balance', () {
    expect(
      WalletAmountValidator.validate('9000', isWithdraw: false, available: 500),
      isNull,
    );
  });

  test('an unknown balance does not block the request', () {
    expect(
      WalletAmountValidator.validate('9000', isWithdraw: true, available: null),
      isNull,
    );
  });
}
