import 'package:equatable/equatable.dart';

class StorefrontOrderItem extends Equatable {
  final int productId;
  final String productName;
  final int quantity;
  final int unitPrice;
  final int unitDiscount;
  final int lineTotal;

  const StorefrontOrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.unitDiscount,
    required this.lineTotal,
  });

  bool get hasUnitDiscount => unitDiscount > 0;

  int get effectiveUnitPrice => unitPrice - unitDiscount;

  @override
  List<Object?> get props => [
    productId,
    productName,
    quantity,
    unitPrice,
    unitDiscount,
    lineTotal,
  ];
}
