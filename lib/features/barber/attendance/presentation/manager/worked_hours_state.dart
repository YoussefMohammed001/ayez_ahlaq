import 'package:equatable/equatable.dart';
import '../../domain/entities/worked_hours.dart';

enum WorkedHoursStatus { initial, loading, success, failure }

class WorkedHoursState extends Equatable {
  final WorkedHoursStatus status;
  final WorkedHours hours;

  const WorkedHoursState({
    this.status = WorkedHoursStatus.initial,
    this.hours = const WorkedHours.none(),
  });

  bool get isVisible => status == WorkedHoursStatus.success;

  @override
  List<Object?> get props => [status, hours];
}
