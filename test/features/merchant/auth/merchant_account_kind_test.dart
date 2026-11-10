import 'package:ayez_ahlaq/features/merchant/auth/domain/entities/merchant_account_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MerchantAccountKind.fromApi', () {
    test('maps SUB_MERCHANT', () {
      expect(
        MerchantAccountKind.fromApi('SUB_MERCHANT'),
        MerchantAccountKind.subMerchant,
      );
    });

    test('maps MERCHANT, null and unknown values to owner', () {
      expect(
        MerchantAccountKind.fromApi('MERCHANT'),
        MerchantAccountKind.owner,
      );
      expect(MerchantAccountKind.fromApi(null), MerchantAccountKind.owner);
      expect(MerchantAccountKind.fromApi('x'), MerchantAccountKind.owner);
    });
  });

  group('MerchantAccountKind.fromName', () {
    test('round-trips stored names', () {
      for (final kind in MerchantAccountKind.values) {
        expect(MerchantAccountKind.fromName(kind.name), kind);
      }
    });

    test('falls back to owner when nothing is stored', () {
      expect(MerchantAccountKind.fromName(''), MerchantAccountKind.owner);
    });
  });

  test('isSubMerchant is true only for subMerchant', () {
    expect(MerchantAccountKind.subMerchant.isSubMerchant, isTrue);
    expect(MerchantAccountKind.owner.isSubMerchant, isFalse);
  });
}
