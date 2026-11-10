import 'package:ayez_ahlaq/shared/auth/data/models/auth_session_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses a sub-merchant login response', () {
    final session = AuthSessionModel.fromJson({
      'token': 't',
      'role': 'MERCHANT',
      'actorId': 4000014,
      'displayName': 'Sub Test',
      'type': 'SUB_MERCHANT',
      'merchantId': 6,
      'mustChangePassword': true,
      'canManageProducts': false,
      'canSell': false,
    });

    expect(session.type, 'SUB_MERCHANT');
    expect(session.merchantId, 6);
    expect(session.mustChangePassword, isTrue);
    expect(session.actorId, 4000014);
  });

  test('parses an owner response with a null merchantId', () {
    final session = AuthSessionModel.fromJson({
      'token': 't',
      'role': 'MERCHANT',
      'actorId': 6,
      'displayName': 'Shop',
      'type': 'MERCHANT',
      'merchantId': null,
      'mustChangePassword': false,
    });

    expect(session.type, 'MERCHANT');
    expect(session.merchantId, isNull);
    expect(session.mustChangePassword, isFalse);
  });

  test('keeps safe defaults for barber and customer responses', () {
    final session = AuthSessionModel.fromJson({
      'token': 't',
      'role': 'BARBER',
      'actorId': 5,
      'displayName': 'Men',
    });

    expect(session.type, '');
    expect(session.merchantId, isNull);
    expect(session.mustChangePassword, isFalse);
  });
}
