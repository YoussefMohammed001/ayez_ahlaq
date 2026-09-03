import 'package:equatable/equatable.dart';
import 'store_product.dart';

class CartLine extends Equatable {
  final StoreProduct product;
  final int quantity;

  const CartLine({required this.product, required this.quantity});

  int get lineTotal => product.effectivePrice * quantity;

  CartLine copyWith({int? quantity}) {
    return CartLine(product: product, quantity: quantity ?? this.quantity);
  }

  @override
  List<Object?> get props => [product, quantity];
}
