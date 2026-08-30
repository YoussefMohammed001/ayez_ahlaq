import 'package:get_it/get_it.dart';
import '../cache/preferences_storage/preferences_storage.dart';

class NumberConverter {
  static PreferencesStorage get _prefs => GetIt.instance<PreferencesStorage>();

  static const _arabicIndicDigits = [
    '٠',
    '١',
    '٢',
    '٣',
    '٤',
    '٥',
    '٦',
    '٧',
    '٨',
    '٩',
  ];

  static const _ones = [
    '',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen',
  ];

  static const _tens = [
    '',
    '',
    'twenty',
    'thirty',
    'forty',
    'fifty',
    'sixty',
    'seventy',
    'eighty',
    'ninety',
  ];

  static String convertNumber(num input) {
    final str = input.toString();
    return _prefs.isArabic() ? _toArabic(str) : _normaliseDigits(str);
  }

  static String convert(dynamic input) {
    final str = input.toString();
    return _prefs.isArabic() ? _toArabic(str) : _normaliseDigits(str);
  }

  static String normaliseDigits(String input) => _normaliseDigits(input);

  static String _toArabic(String input) {
    return input.split('').map((ch) {
      final digit = int.tryParse(ch);
      return digit != null ? _arabicIndicDigits[digit] : ch;
    }).join();
  }

  static String _toEnglish(String input) {
    final normalised = _normaliseDigits(input);
    return normalised.replaceAllMapped(RegExp(r'\d+'), (match) {
      final number = int.tryParse(match.group(0)!);
      if (number == null) return match.group(0)!;
      return _numberToWords(number);
    });
  }

  static String _normaliseDigits(String input) {
    return input.split('').map((ch) {
      final index = _arabicIndicDigits.indexOf(ch);
      return index != -1 ? '$index' : ch;
    }).join();
  }

  static String _numberToWords(int number) {
    if (number == 0) return 'zero';
    if (number < 0) return 'negative ${_numberToWords(-number)}';
    return _chunk(number).trim();
  }

  static String _chunk(int n) {
    if (n < 20) return _ones[n];
    if (n < 100) {
      final r = n % 10;
      return _tens[n ~/ 10] + (r != 0 ? '-${_ones[r]}' : '');
    }
    if (n < 1_000) {
      return '${_ones[n ~/ 100]} hundred'
          '${n % 100 != 0 ? ' ${_chunk(n % 100)}' : ''}';
    }
    if (n < 1_000_000) {
      return '${_chunk(n ~/ 1_000)} thousand'
          '${n % 1_000 != 0 ? ' ${_chunk(n % 1_000)}' : ''}';
    }
    if (n < 1_000_000_000) {
      return '${_chunk(n ~/ 1_000_000)} million'
          '${n % 1_000_000 != 0 ? ' ${_chunk(n % 1_000_000)}' : ''}';
    }
    return '${_chunk(n ~/ 1_000_000_000)} billion'
        '${n % 1_000_000_000 != 0 ? ' ${_chunk(n % 1_000_000_000)}' : ''}';
  }
}
