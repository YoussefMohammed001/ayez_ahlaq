import 'package:equatable/equatable.dart';
import 'money_direction.dart';

class MoneyOccurrence extends Equatable {
  final int id;
  final String description;
  final int amount;
  final MoneyDirection direction;
  final DateTime? occurrenceDate;

  const MoneyOccurrence({
    required this.id,
    required this.description,
    required this.amount,
    required this.direction,
    this.occurrenceDate,
  });

  @override
  List<Object?> get props => [id, description, amount, direction, occurrenceDate];
}
