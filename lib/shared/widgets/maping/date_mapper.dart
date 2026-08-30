import 'package:flutter/material.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/di/services_locator.dart';

class DateHelper {
  static DateTime? parseFromApi(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;

    try {
      return DateTime.parse(dateString);
    } catch (e) {
      debugPrint('Failed to parse date: $dateString, error: $e');
      return null;
    }
  }

  static String formatForDisplay(DateTime date) {
    final lang = sl<PreferencesStorage>().getCurrentLanguage();

    if (lang == "ar") {
      return formatDateArabic(date);
    } else {
      return formatDateEnglish(date);
    }
  }

  static String formatDateEnglish(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  static String formatDateArabic(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    final englishDate = '$day/$month/$year';
    return _convertToArabicNumerals(englishDate);
  }

  static String formatForApi(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static String _convertToArabicNumerals(String input) {
    const englishNumerals = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabicNumerals = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    String result = input;
    for (int i = 0; i < englishNumerals.length; i++) {
      result = result.replaceAll(englishNumerals[i], arabicNumerals[i]);
    }
    return result;
  }

  static String _convertToEnglishNumerals(String input) {
    const englishNumerals = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabicNumerals = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    String result = input;
    for (int i = 0; i < arabicNumerals.length; i++) {
      result = result.replaceAll(arabicNumerals[i], englishNumerals[i]);
    }
    return result;
  }
}
