import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/helpers/safe_print.dart';
import '../di/services_locator.dart';

class AppDateTime {
  static String convertArabicNumbersToEnglish(String input) {
    const arabicNums = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (var i = 0; i < arabicNums.length; i++) {
      input = input.replaceAll(arabicNums[i], i.toString());
    }
    return input;
  }

  static String convertEnglishNumbersToArabic(String input) {
    const arabicNums = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (var i = 0; i < 10; i++) {
      input = input.replaceAll(i.toString(), arabicNums[i]);
    }
    return input;
  }

  static String utcToLocalTime(String timestamp) {
    try {
      timestamp = convertArabicNumbersToEnglish(timestamp);

      if (!timestamp.contains('Z') && !timestamp.contains('+')) {
        timestamp = '${timestamp.trim()}Z';
      }

      final dateTime = DateTime.parse(timestamp);
      final localTime = dateTime.toLocal();
      return DateFormat("yyyy-MM-dd HH:mm", "en").format(localTime);
    } catch (e) {
      safePrint("utcToLocalTime error: $e");
      return timestamp;
    }
  }

  static String utcToLocalTimeOnly(String timestamp) {
    try {
      timestamp = convertArabicNumbersToEnglish(timestamp);
      initializeDateFormatting(
        sl<PreferencesStorage>().getCurrentLanguage(),
        "",
      );
      final dateTime = DateTime.parse(timestamp);
      final localTime = dateTime.toLocal();
      var formatted = DateFormat(
        "HH:mm",
        sl<PreferencesStorage>().getCurrentLanguage(),
      ).format(localTime);
      if (sl<PreferencesStorage>().getCurrentLanguage() == "ar") {
        formatted = convertEnglishNumbersToArabic(formatted);
      }
      return formatted;
    } catch (e) {
      safePrint("utcToLocalTimeOnly error: $e");
      return timestamp;
    }
  }

  static String utcToLocalDateOnly(String timestamp) {
    try {
      timestamp = convertArabicNumbersToEnglish(timestamp);
      final dateTime = DateTime.parse(timestamp);
      final localTime = dateTime.toLocal();
      var formatted = DateFormat("yyyy-MM-dd", "en").format(localTime);
      if (sl<PreferencesStorage>().getCurrentLanguage() == "ar") {
        formatted = convertEnglishNumbersToArabic(formatted);
      }
      return formatted;
    } catch (e) {
      safePrint("utcToLocalDateOnly error: $e");
      return timestamp;
    }
  }

  static String timestampToFormatted(String timestamp) {
    try {
      timestamp = convertArabicNumbersToEnglish(timestamp);
      final dateTime = DateTime.parse(timestamp);
      var formatted = DateFormat("yyyy-MM-dd HH:mm a", "en").format(dateTime);
      if (sl<PreferencesStorage>().getCurrentLanguage() == "ar") {
        formatted = convertEnglishNumbersToArabic(
          formatted,
        ).replaceAll("AM", "ص").replaceAll("PM", "م");
      }
      return formatted;
    } catch (e) {
      safePrint("timestampToFormatted error: $e");
      return timestamp;
    }
  }

  static String formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    var twoDigitMinutes = duration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    var twoDigitSeconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    var result = '$twoDigitMinutes:$twoDigitSeconds';
    if (sl<PreferencesStorage>().getCurrentLanguage() == "ar") {
      result = convertEnglishNumbersToArabic(result);
    }
    return result;
  }

  static String combineToTimestamp(String dateStr, String hourStr) {
    try {
      dateStr = convertArabicNumbersToEnglish(dateStr);
      hourStr = convertArabicNumbersToEnglish(hourStr);
      final dateTime = DateTime.parse("$dateStr $hourStr:00");
      final utcDateTime = dateTime.toUtc();
      final formatted = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(utcDateTime);
      return "$formatted+0000";
    } catch (e) {
      safePrint("Error combining date/hour: $e");
      return "";
    }
  }

  static TimeOfDay parseTime(String hhmm) {
    final parts = hhmm.split(':');
    return TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 0,
      minute: parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0,
    );
  }

  static String toApiTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:00';

  static String formatDate(DateTime d) {
    return DateFormat('dd MMM yyyy', 'en').format(d);
  }

  static String formatDateTime(DateTime d) {
    return DateFormat('dd MMM yyyy · HH:mm', 'en').format(d);
  }

  static String formatDateForApi(DateTime d) {
    return DateFormat('yyyy-MM-dd', 'en').format(d);
  }

  static String formatHour(String hour24, [BuildContext? context]) {
    try {
      final lang = sl<PreferencesStorage>().getCurrentLanguage();
      final parts = hour24.split(":");
      if (parts.length < 2) return hour24;
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      String period = "AM";
      if (hour >= 12) {
        period = "PM";
        if (hour > 12) hour -= 12;
      } else if (hour == 0) {
        hour = 12;
      }
      var formatted =
          "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";
      if (lang == "ar") {
        final arabicPeriod = period == "AM" ? "ص" : "م";
        formatted =
            "${convertEnglishNumbersToArabic(hour.toString().padLeft(2, '0'))}:${convertEnglishNumbersToArabic(minute.toString().padLeft(2, '0'))} $arabicPeriod";
      }
      return formatted;
    } catch (e) {
      safePrint("formatHour could not parse: $hour24");
      return hour24;
    }
  }
}
