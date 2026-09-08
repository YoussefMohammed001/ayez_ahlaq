import 'package:equatable/equatable.dart';

class Drink extends Equatable {
  final int id;
  final String name;
  final int price;
  final bool active;
  final int sortOrder;

  const Drink({
    required this.id,
    required this.name,
    required this.price,
    required this.active,
    required this.sortOrder,
  });

  @override
  List<Object?> get props => [id, name, price, active, sortOrder];
}
