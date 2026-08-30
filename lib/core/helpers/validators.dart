import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:ayez_ahlaq/shared/widgets/maping/date_mapper.dart';

class Validators {
  static bool isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z][\w.-]*@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  static bool isNotValidEmail(String email) => !isValidEmail(email);

  static bool isValidPassword(String password) {
    return RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9].*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    ).hasMatch(password);
  }

  static bool isNotValidPassword(String password) => !isValidPassword(password);

  static bool isSaudiPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^05[0-9]{8}$').hasMatch(phoneNumber);
  }

  static bool isValidSaudiID(String id) {
    if (!RegExp(r'^[12]\d{9}$').hasMatch(id)) return false;
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      int digit = int.parse(id[i]);
      if (i % 2 == 0) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
    }
    int checkDigit = int.parse(id[9]);
    int calculatedCheck = (10 - (sum % 10)) % 10;

    return checkDigit == calculatedCheck;
  }

  static String? validatePhoneNumber(String? value, {bool isRequired = true}) {
    final s = S();

    if (value == null || value.isEmpty) {
      return isRequired ? s.phone_number_is_required : null;
    }
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (!RegExp(r'^\d+$').hasMatch(digitsOnly)) {
      return s.phone_number_must_contain_only_digits;
    }

    if (digitsOnly.startsWith('00')) {
      return s.phone_number_cannot_start_with_double_zero;
    }

    if (digitsOnly.startsWith('0')) {
      return s.remove_leading_zero;
    }
    if (digitsOnly.length < 10 || digitsOnly.length > 15) {
      return s.please_enter_a_valid_phone_number;
    }

    return null;
  }

  static bool isEgyptianPhoneNumberValid(String phone) {
    final digitsOnly = phone.replaceAll(RegExp(r'[^\d]'), '');

    return RegExp(r'^01[0-2,5][0-9]{8}$').hasMatch(digitsOnly);
  }

  static String? validateName(
    String? value, {
    bool isRequired = true,
    int minLength = 3,
    int maxLength = 50,
    bool allowMultipleWords = true,
  }) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? S().name_required : null;
    }

    final name = value.trim();

    if (name.length < minLength) {
      return S().name_too_short;
    }

    if (name.length > maxLength) {
      return S().name_too_long;
    }

    if (name.contains(RegExp(r'\s{2,}'))) {
      return S().name_invalid_spacing;
    }

    final nameRegex = allowMultipleWords
        ? RegExp(r'^[a-zA-Z\u0600-\u06FF]+(\s[a-zA-Z\u0600-\u06FF]+)*$')
        : RegExp(r'^[a-zA-Z\u0600-\u06FF]+$');

    if (!nameRegex.hasMatch(name)) {
      return S().name_invalid_characters;
    }

    return null;
  }

  static String? validateArabicName(
    String? value, {
    bool isRequired = true,
    int minWords = 2,
  }) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? S().arabic_name_required : null;
    }

    final name = value.trim();

    if (name.contains(RegExp(r'\s{2,}'))) {
      return S().name_invalid_spacing;
    }

    final arabicRegex = RegExp(r'^[\u0600-\u06FF]+(\s[\u0600-\u06FF]+)*$');

    if (!arabicRegex.hasMatch(name)) {
      return S().arabic_name_required;
    }

    final words = name.split(' ');
    if (words.length < minWords) {
      return S().arabic_full_name_required;
    }

    return null;
  }

  static String? validateAddress(String? value, {bool isRequired = true}) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? S().address_required : null;
    }
    return null;
  }

  static String? validateEmail(String? value, {bool isRequired = true}) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? S().email_required : null;
    }
    if (!isValidEmail(value.trim())) {
      return S().email_invalid;
    }
    return null;
  }

  static String? validateNationalId(String? value, {bool isRequired = true}) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? S().national_id_required : null;
    }

    final id = value.trim();

    if (id.length != 14) {
      return S().national_id_must_be_14_digits;
    }

    if (!RegExp(r'^[0-9]{14}$').hasMatch(id)) {
      return S().invalid_national_id;
    }

    final century = id.substring(0, 1);
    if (!['2', '3'].contains(century)) {
      return S().invalid_national_id;
    }

    final year = int.tryParse(id.substring(1, 3));
    final month = int.tryParse(id.substring(3, 5));
    final day = int.tryParse(id.substring(5, 7));

    if (year == null || month == null || day == null) {
      return S().invalid_national_id;
    }

    if (month < 1 || month > 12) {
      return S().invalid_national_id;
    }

    if (day < 1 || day > 31) {
      return S().invalid_national_id;
    }

    final governorate = int.tryParse(id.substring(7, 9));
    if (governorate == null || governorate < 1 || governorate > 35) {
      return S().invalid_national_id;
    }

    return null;
  }

  static DateTime? extractBirthDateFromNationalId(String nationalId) {
    if (nationalId.length != 14) return null;

    try {
      final centuryDigit = int.parse(nationalId[0]);
      final year = int.parse(nationalId.substring(1, 3));
      final month = int.parse(nationalId.substring(3, 5));
      final day = int.parse(nationalId.substring(5, 7));

      int fullYear;
      if (centuryDigit == 2) {
        fullYear = 1900 + year;
      } else if (centuryDigit == 3) {
        fullYear = 2000 + year;
      } else {
        return null;
      }

      if (month < 1 || month > 12 || day < 1 || day > 31) {
        return null;
      }

      final birthDate = DateTime(fullYear, month, day);

      if (birthDate.isAfter(DateTime.now())) {
        return null;
      }

      return birthDate;
    } catch (e) {
      return null;
    }
  }

  static bool validateBirthDateMatchesNationalId(
    String nationalId,
    DateTime selectedBirthDate,
  ) {
    final extractedDate = extractBirthDateFromNationalId(nationalId);
    if (extractedDate == null) return false;

    return extractedDate.year == selectedBirthDate.year &&
        extractedDate.month == selectedBirthDate.month &&
        extractedDate.day == selectedBirthDate.day;
  }

  static String? getBirthDateErrorFromNationalId(
    String nationalId,
    DateTime? selectedBirthDate,
  ) {
    if (selectedBirthDate == null) return null;
    if (nationalId.length != 14) return null;

    final extractedDate = extractBirthDateFromNationalId(nationalId);
    if (extractedDate == null) return null;

    if (!validateBirthDateMatchesNationalId(nationalId, selectedBirthDate)) {
      final formattedDate = DateHelper.formatForDisplay(extractedDate);
      return "${S().birthdate_does_not_match_national_id} $formattedDate";
    }

    return null;
  }

  static String? validatePassport(String? value, {bool isRequired = true}) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? S().passport_required : null;
    }

    final passport = value.trim().toUpperCase();

    if (passport.length < 6 || passport.length > 20) {
      return S().passport_length_invalid;
    }

    if (!RegExp(r'^[A-Z0-9]+$').hasMatch(passport)) {
      return S().passport_format_invalid;
    }

    return null;
  }

  static String? validateDropdown<T>(
    T? value,
    String errorMessage, {
    bool isRequired = true,
  }) {
    if (value == null) {
      return isRequired ? errorMessage : null;
    }
    return null;
  }

  static bool isNumeric(String input) {
    return RegExp(r'^[0-9]+$').hasMatch(input);
  }

  static String? validateMessage(String? value, {bool isRequired = true}) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? S().message_required : null;
    }
    if (value.trim().length < 10) {
      return S().message_too_short;
    }
    return null;
  }

  static String? validateRequired(String? value, {bool isRequired = true}) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? S().field_required : null;
    }
    return null;
  }
}
