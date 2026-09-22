import 'package:equatable/equatable.dart';
import 'money_direction.dart';
import 'money_frequency.dart';

class MoneyItem extends Equatable {
  final int id;
  final String description;
  final int amount;
  final MoneyDirection direction;
  final MoneyFrequency frequency;
  final int? dayOfWeek;
  final int? dayOfMonth;
  final bool active;

  const MoneyItem({
    required this.id,
    required this.description,
    required this.amount,
    required this.direction,
    required this.frequency,
    this.dayOfWeek,
    this.dayOfMonth,
    required this.active,
  });

  @override
  List<Object?> get props => [
    id,
    description,
    amount,
    direction,
    frequency,
    dayOfWeek,
    dayOfMonth,
    active,
  ];
}
