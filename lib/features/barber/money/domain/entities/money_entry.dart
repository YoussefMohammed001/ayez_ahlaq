import 'package:equatable/equatable.dart';
import 'money_direction.dart';

class MoneyEntry extends Equatable {
  final int id;
  final String description;
  final int amount;
  final MoneyDirection direction;
  final DateTime? entryDate;

  const MoneyEntry({
    required this.id,
    required this.description,
    required this.amount,
    required this.direction,
    this.entryDate,
  });

  @override
  List<Object?> get props => [id, description, amount, direction, entryDate];
}
