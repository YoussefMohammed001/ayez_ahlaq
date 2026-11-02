import 'package:equatable/equatable.dart';

class WorkingDay extends Equatable {
  final int dayOfWeek;
  final bool isOpen;
  final String openTime;
  final String closeTime;

  const WorkingDay({
    required this.dayOfWeek,
    required this.isOpen,
    required this.openTime,
    required this.closeTime,
  });

  const WorkingDay.closed(this.dayOfWeek)
    : isOpen = false,
      openTime = '10:00',
      closeTime = '22:00';

  WorkingDay copyWith({bool? isOpen, String? openTime, String? closeTime}) {
    return WorkingDay(
      dayOfWeek: dayOfWeek,
      isOpen: isOpen ?? this.isOpen,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
    );
  }

  int get openMinutes => _minutesOf(openTime);

  int get closeMinutes => _minutesOf(closeTime);

  bool get closesNextDay => closeMinutes < openMinutes;

  bool get hasSameOpenAndClose => closeMinutes == openMinutes;

  int get durationMinutes =>
      (closeMinutes - openMinutes + Duration.minutesPerDay) %
      Duration.minutesPerDay;

  static int _minutesOf(String time) {
    final parts = time.split(':');
    final hour = int.tryParse(parts.elementAtOrNull(0) ?? '') ?? 0;
    final minute = int.tryParse(parts.elementAtOrNull(1) ?? '') ?? 0;
    return hour * Duration.minutesPerHour + minute;
  }

  @override
  List<Object?> get props => [dayOfWeek, isOpen, openTime, closeTime];
}
