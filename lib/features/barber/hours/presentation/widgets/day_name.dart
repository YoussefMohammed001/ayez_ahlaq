import '../../../../../generated/l10n.dart';

enum DayName {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  static const byDayOfWeek = [
    DayName.sunday,
    DayName.monday,
    DayName.tuesday,
    DayName.wednesday,
    DayName.thursday,
    DayName.friday,
    DayName.saturday,
  ];

  String label() => switch (this) {
    DayName.monday => S().dayMonday,
    DayName.tuesday => S().dayTuesday,
    DayName.wednesday => S().dayWednesday,
    DayName.thursday => S().dayThursday,
    DayName.friday => S().dayFriday,
    DayName.saturday => S().daySaturday,
    DayName.sunday => S().daySunday,
  };
}
