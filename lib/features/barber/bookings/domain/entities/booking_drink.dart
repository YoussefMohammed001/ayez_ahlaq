import 'package:equatable/equatable.dart';

class BookingDrink extends Equatable {
  final int drinkId;
  final int quantity;
  final String? name;
  final int? price;

  const BookingDrink({
    required this.drinkId,
    required this.quantity,
    this.name,
    this.price,
  });

  @override
  List<Object?> get props => [drinkId, quantity, name, price];
}
