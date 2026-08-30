class WeekDay {
  final String day;
  final String hours;
  bool isOff;
  final bool isToday;

  WeekDay({required this.day, required this.hours, this.isOff = false, this.isToday = false});
}
