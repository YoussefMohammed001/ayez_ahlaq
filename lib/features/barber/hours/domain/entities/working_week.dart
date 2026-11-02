import 'working_day.dart';

extension WorkingWeek on List<WorkingDay> {
  bool get isValid => every((day) => !day.isOpen || !day.hasSameOpenAndClose);
}
