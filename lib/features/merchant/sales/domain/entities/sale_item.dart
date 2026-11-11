import 'package:equatable/equatable.dart';

class SaleItem extends Equatable {
  final int productId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final double lineTotal;

  const SaleItem({
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.lineTotal,
  });

  @override
  List<Object?> get props => [
    productId,
    productName,
    unitPrice,
    quantity,
    lineTotal,
  ];
}
