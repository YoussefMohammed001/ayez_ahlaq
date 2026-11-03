import '../../../../../generated/l10n.dart';

class TempPasswordValidator {
  static const minLength = 6;

  const TempPasswordValidator._();

  static String? required(String? value) =>
      (value ?? '').length < minLength ? S().memberTempPasswordInvalid : null;

  static String? optional(String? value) =>
      (value ?? '').isEmpty ? null : required(value);
}
