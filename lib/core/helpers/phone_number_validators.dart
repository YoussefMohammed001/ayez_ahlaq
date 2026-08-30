import 'package:flutter/services.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class CountryPhoneValidators {
  static String? validatePhoneByCountry(String? value, String countryCode) {
    final s = S();

    if (value == null || value.isEmpty) {
      return s.phone_number_is_required;
    }

    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (!RegExp(r'^\d+$').hasMatch(digitsOnly)) {
      return s.phone_number_must_contain_only_digits;
    }

    if (digitsOnly.startsWith('00')) {
      return s.phone_number_cannot_start_with_double_zero;
    }

    switch (countryCode) {
      case 'EG':
        return _validateEgyptPhone(digitsOnly, s);
      case 'SA':
        return _validateSaudiPhone(digitsOnly, s);
      case 'AE':
        return _validateUAEPhone(digitsOnly, s);
      case 'KW':
        return _validateKuwaitPhone(digitsOnly, s);
      case 'QA':
        return _validateQatarPhone(digitsOnly, s);
      case 'BH':
        return _validateBahrainPhone(digitsOnly, s);
      case 'OM':
        return _validateOmanPhone(digitsOnly, s);
      case 'JO':
        return _validateJordanPhone(digitsOnly, s);
      case 'LB':
        return _validateLebanonPhone(digitsOnly, s);
      case 'IQ':
        return _validateIraqPhone(digitsOnly, s);
      case 'SY':
        return _validateSyriaPhone(digitsOnly, s);
      case 'YE':
        return _validateYemenPhone(digitsOnly, s);
      case 'PS':
        return _validatePalestinePhone(digitsOnly, s);
      case 'US':
      case 'CA':
        return _validateNorthAmericaPhone(digitsOnly, s);
      case 'GB':
        return _validateUKPhone(digitsOnly, s);
      case 'DE':
        return _validateGermanyPhone(digitsOnly, s);
      case 'FR':
        return _validateFrancePhone(digitsOnly, s);
      case 'IT':
        return _validateItalyPhone(digitsOnly, s);
      case 'ES':
        return _validateSpainPhone(digitsOnly, s);
      case 'TR':
        return _validateTurkeyPhone(digitsOnly, s);
      case 'IN':
        return _validateIndiaPhone(digitsOnly, s);
      case 'PK':
        return _validatePakistanPhone(digitsOnly, s);
      case 'BD':
        return _validateBangladeshPhone(digitsOnly, s);
      case 'CN':
        return _validateChinaPhone(digitsOnly, s);
      case 'JP':
        return _validateJapanPhone(digitsOnly, s);
      case 'KR':
        return _validateKoreaPhone(digitsOnly, s);
      case 'AU':
        return _validateAustraliaPhone(digitsOnly, s);
      case 'BR':
        return _validateBrazilPhone(digitsOnly, s);
      case 'MX':
        return _validateMexicoPhone(digitsOnly, s);
      case 'ZA':
        return _validateSouthAfricaPhone(digitsOnly, s);
      default:
        return _validateGenericPhone(digitsOnly, s);
    }
  }

  static String? _validateEgyptPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 10) {
      return s.please_enter_a_valid_phone_number;
    }

    final validPrefixes = ['10', '11', '12', '15'];
    final prefix = normalizedPhone.substring(0, 2);

    if (!validPrefixes.contains(prefix)) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateSaudiPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 9) {
      return s.please_enter_a_valid_phone_number;
    }

    if (!normalizedPhone.startsWith('5')) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateUAEPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 9) {
      return s.please_enter_a_valid_phone_number;
    }

    final validPrefixes = ['50', '52', '54', '55', '56', '58'];
    final prefix = normalizedPhone.substring(0, 2);

    if (!validPrefixes.contains(prefix)) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateKuwaitPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 8) {
      return s.please_enter_a_valid_phone_number;
    }

    final validPrefixes = ['5', '6', '9'];
    if (!validPrefixes.contains(normalizedPhone[0])) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateQatarPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 8) {
      return s.please_enter_a_valid_phone_number;
    }

    final validPrefixes = ['3', '5', '6', '7'];
    if (!validPrefixes.contains(normalizedPhone[0])) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateBahrainPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 8) {
      return s.please_enter_a_valid_phone_number;
    }

    final validPrefixes = ['3', '6'];
    if (!validPrefixes.contains(normalizedPhone[0])) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateOmanPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 8) {
      return s.please_enter_a_valid_phone_number;
    }

    final validPrefixes = ['7', '9'];
    if (!validPrefixes.contains(normalizedPhone[0])) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateJordanPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 9) {
      return s.please_enter_a_valid_phone_number;
    }

    if (!normalizedPhone.startsWith('7')) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateLebanonPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 8 && normalizedPhone.length != 7) {
      return s.please_enter_a_valid_phone_number;
    }

    final validPrefixes = ['3', '7', '8'];
    if (!validPrefixes.contains(normalizedPhone[0])) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateIraqPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 10) {
      return s.please_enter_a_valid_phone_number;
    }

    if (!normalizedPhone.startsWith('7')) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateSyriaPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 9) {
      return s.please_enter_a_valid_phone_number;
    }

    if (!normalizedPhone.startsWith('9')) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateYemenPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 9) {
      return s.please_enter_a_valid_phone_number;
    }

    if (!normalizedPhone.startsWith('7')) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validatePalestinePhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 9) {
      return s.please_enter_a_valid_phone_number;
    }

    final validPrefixes = ['5'];
    if (!validPrefixes.contains(normalizedPhone[0])) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateNorthAmericaPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('1')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 10) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateUKPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length < 9 || normalizedPhone.length > 10) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateGermanyPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length < 10 || normalizedPhone.length > 11) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateFrancePhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 9) {
      return s.please_enter_a_valid_phone_number;
    }

    final validPrefixes = ['6', '7'];
    if (!validPrefixes.contains(normalizedPhone[0])) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateItalyPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 9 && normalizedPhone.length != 10) {
      return s.please_enter_a_valid_phone_number;
    }

    if (!normalizedPhone.startsWith('3')) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateSpainPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 9) {
      return s.please_enter_a_valid_phone_number;
    }

    final validPrefixes = ['6', '7'];
    if (!validPrefixes.contains(normalizedPhone[0])) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateTurkeyPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 10) {
      return s.please_enter_a_valid_phone_number;
    }

    if (!normalizedPhone.startsWith('5')) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateIndiaPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 10) {
      return s.please_enter_a_valid_phone_number;
    }

    final validPrefixes = ['6', '7', '8', '9'];
    if (!validPrefixes.contains(normalizedPhone[0])) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validatePakistanPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 10) {
      return s.please_enter_a_valid_phone_number;
    }

    if (!normalizedPhone.startsWith('3')) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateBangladeshPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 10) {
      return s.please_enter_a_valid_phone_number;
    }

    if (!normalizedPhone.startsWith('1')) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateChinaPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 11) {
      return s.please_enter_a_valid_phone_number;
    }

    if (!normalizedPhone.startsWith('1')) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateJapanPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 10) {
      return s.please_enter_a_valid_phone_number;
    }

    final validPrefixes = ['70', '80', '90'];
    final prefix = normalizedPhone.substring(0, 2);

    if (!validPrefixes.contains(prefix)) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateKoreaPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 9 && normalizedPhone.length != 10) {
      return s.please_enter_a_valid_phone_number;
    }

    if (!normalizedPhone.startsWith('1')) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateAustraliaPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 9) {
      return s.please_enter_a_valid_phone_number;
    }

    if (!normalizedPhone.startsWith('4')) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateBrazilPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 11) {
      return s.please_enter_a_valid_phone_number;
    }

    final validPrefixes = ['9'];
    if (!validPrefixes.contains(normalizedPhone[2])) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateMexicoPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 10) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateSouthAfricaPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length != 9) {
      return s.please_enter_a_valid_phone_number;
    }

    final validPrefixes = ['6', '7', '8'];
    if (!validPrefixes.contains(normalizedPhone[0])) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static String? _validateGenericPhone(String phone, S s) {
    String normalizedPhone = phone;
    if (normalizedPhone.startsWith('0')) {
      normalizedPhone = normalizedPhone.substring(1);
    }

    if (normalizedPhone.length < 7 || normalizedPhone.length > 15) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }
}

class PhoneLengthFormatter extends TextInputFormatter {
  final String countryCode;

  PhoneLengthFormatter(this.countryCode);

  int get maxLength {
    switch (countryCode) {
      case 'EG':
        return 10;
      case 'SA':
        return 10;
      case 'AE':
        return 10;
      case 'KW':
        return 9;
      case 'QA':
        return 9;
      case 'BH':
        return 9;
      case 'OM':
        return 9;
      case 'JO':
        return 10;
      case 'LB':
        return 9;
      case 'IQ':
        return 11;
      case 'SY':
        return 10;
      case 'YE':
        return 10;
      case 'PS':
        return 10;
      case 'US':
      case 'CA':
        return 11;
      case 'GB':
        return 11;
      case 'DE':
        return 12;
      case 'FR':
        return 10;
      case 'IT':
        return 11;
      case 'ES':
        return 10;
      case 'TR':
        return 11;
      case 'IN':
        return 11;
      case 'PK':
        return 11;
      case 'BD':
        return 11;
      case 'CN':
        return 12;
      case 'JP':
        return 11;
      case 'KR':
        return 11;
      case 'AU':
        return 10;
      case 'BR':
        return 12;
      case 'MX':
        return 11;
      case 'ZA':
        return 10;
      default:
        return 15;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length > maxLength) {
      return oldValue;
    }

    if (newValue.text.startsWith('00')) {
      return oldValue;
    }

    return newValue;
  }
}
