import 'package:equatable/equatable.dart';

class StorefrontOrderItem extends Equatable {
  final int productId;
  final String productName;
  final int quantity;
  final int unitPrice;
  final int lineTotal;

  const StorefrontOrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
  });

  @override
  List<Object?> get props => [productId, quantity, lineTotal];
}
