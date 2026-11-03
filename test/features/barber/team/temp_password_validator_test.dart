import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/features/barber/team/presentation/helpers/temp_password_validator.dart';

void main() {
  test('required rejects empty and short passwords', () {
    expect(TempPasswordValidator.required(null), isNotNull);
    expect(TempPasswordValidator.required(''), isNotNull);
    expect(TempPasswordValidator.required('12345'), isNotNull);
  });

  test('required accepts six characters or more', () {
    expect(TempPasswordValidator.required('123456'), isNull);
    expect(TempPasswordValidator.required('Abc12345'), isNull);
  });

  test('optional accepts a blank value but still checks a typed one', () {
    expect(TempPasswordValidator.optional(null), isNull);
    expect(TempPasswordValidator.optional(''), isNull);
    expect(TempPasswordValidator.optional('123'), isNotNull);
    expect(TempPasswordValidator.optional('123456'), isNull);
  });
}
