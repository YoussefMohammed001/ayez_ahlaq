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

  @override
  List<Object?> get props => [dayOfWeek, isOpen, openTime, closeTime];
}
