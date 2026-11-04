import '../../../../../core/helpers/app_date_time.dart';

class AttendanceTimeLabel {
  const AttendanceTimeLabel._();

  static String time(DateTime value) =>
      AppDateTime.formatHour('${_two(value.hour)}:${_two(value.minute)}');

  static String date(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-${_two(value.month)}-${_two(value.day)}';

  static String _two(int number) => number.toString().padLeft(2, '0');
}
