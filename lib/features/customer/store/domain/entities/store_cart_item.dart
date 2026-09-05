import 'package:equatable/equatable.dart';

class StoreCartItem extends Equatable {
  final int productId;
  final int quantity;

  const StoreCartItem({required this.productId, required this.quantity});

  StoreCartItem copyWith({int? quantity}) {
    return StoreCartItem(productId: productId, quantity: quantity ?? this.quantity);
  }

  @override
  List<Object?> get props => [productId, quantity];
}
