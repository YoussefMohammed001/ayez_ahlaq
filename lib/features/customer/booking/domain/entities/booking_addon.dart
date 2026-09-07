import 'package:equatable/equatable.dart';

class BookingAddon extends Equatable {
  final int productId;
  final int quantity;
  final String? name;
  final int? price;

  const BookingAddon({
    required this.productId,
    required this.quantity,
    this.name,
    this.price,
  });

  @override
  List<Object?> get props => [productId, quantity, name, price];
}
