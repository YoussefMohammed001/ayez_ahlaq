import 'package:equatable/equatable.dart';
import '../../../../barber/hours/domain/entities/working_day.dart';

enum MyScheduleStatus { initial, loading, success, failure }

class MyScheduleState extends Equatable {
  final MyScheduleStatus status;
  final List<WorkingDay> days;

  const MyScheduleState({
    this.status = MyScheduleStatus.initial,
    this.days = const [],
  });

  @override
  List<Object?> get props => [status, days];
}
