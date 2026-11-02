import 'package:intl/intl.dart';
import '../../../../../core/helpers/app_date_time.dart';

class AttendanceTimeLabel {
  const AttendanceTimeLabel._();

  static String time(DateTime value) =>
      AppDateTime.formatHour(DateFormat('HH:mm', 'en').format(value));

  static String date(DateTime value) =>
      DateFormat('yyyy-MM-dd', 'en').format(value);
}
