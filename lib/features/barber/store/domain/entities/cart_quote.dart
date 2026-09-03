import 'package:equatable/equatable.dart';

class CartQuote extends Equatable {
  final int subtotal;
  final int deliveryFee;
  final int total;

  const CartQuote({required this.subtotal, required this.deliveryFee, required this.total});

  @override
  List<Object?> get props => [subtotal, deliveryFee, total];
}
