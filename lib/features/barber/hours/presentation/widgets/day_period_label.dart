import '../../../../../generated/l10n.dart';

class DayPeriodLabel {
  const DayPeriodLabel._();

  static String of(String time) {
    final hour = int.tryParse(time.split(':').first) ?? 0;
    final minute = int.tryParse(time.split(':').elementAtOrNull(1) ?? '') ?? 0;

    if (hour == 0 && minute == 0) return S().hourPeriodMidnight;
    if (hour < 4) return S().hourPeriodNight;
    if (hour < 12) return S().hourPeriodMorning;
    if (hour < 15) return S().hourPeriodNoon;
    if (hour < 18) return S().hourPeriodAfternoon;
    if (hour < 21) return S().hourPeriodEvening;
    return S().hourPeriodNight;
  }
}
