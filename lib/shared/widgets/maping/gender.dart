import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/di/services_locator.dart';

class Gender {
  static List<Map<String, String>> getAll() {
    return [
      {"code": "Male", "name_en": "Male", "name_ar": "ذكر"},
      {"code": "Female", "name_en": "Female", "name_ar": "أنثى"},
    ];
  }

  static String nameFromCode(String code) {
    final lang = sl<PreferencesStorage>().getCurrentLanguage();
    final match = getAll().firstWhere(
      (n) => n["code"] == code,
      orElse: () => {"code": code, "name_ar": code, "name_en": code},
    );
    return lang == "ar" ? match["name_ar"]! : match["name_en"]!;
  }

  static String codeFromName(String localizedValue) {
    final lang = sl<PreferencesStorage>().getCurrentLanguage();
    final match = getAll().firstWhere(
      (n) => lang == "ar"
          ? n["name_ar"] == localizedValue
          : n["name_en"] == localizedValue,
      orElse: () => {"code": localizedValue},
    );
    return match["code"]!;
  }
}
