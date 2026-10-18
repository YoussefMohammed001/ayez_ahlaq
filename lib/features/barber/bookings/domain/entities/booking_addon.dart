import 'package:equatable/equatable.dart';

class BookingAddon extends Equatable {
  final int productId;
  final int quantity;
  final String? name;
  final int? price;
  final int? unitDiscount;
  final int? lineTotal;
  final int? drinkId;

  const BookingAddon({
    required this.productId,
    required this.quantity,
    this.name,
    this.price,
    this.unitDiscount,
    this.lineTotal,
    this.drinkId,
  });

  bool get isDrink => drinkId != null;

  @override
  List<Object?> get props => [
    productId,
    quantity,
    name,
    price,
    unitDiscount,
    lineTotal,
    drinkId,
  ];
}
