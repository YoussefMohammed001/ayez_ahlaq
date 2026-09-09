import 'package:equatable/equatable.dart';

class StoreCartLine extends Equatable {
  final int productId;
  final String productName;
  final int quantity;
  final int unitPrice;
  final int unitDiscount;
  final int netUnitPrice;
  final int lineTotal;
  final int minOrderQty;
  final bool available;
  final String? unavailableReason;

  const StoreCartLine({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.unitDiscount,
    required this.netUnitPrice,
    required this.lineTotal,
    required this.minOrderQty,
    required this.available,
    this.unavailableReason,
  });

  @override
  List<Object?> get props => [
    productId,
    productName,
    quantity,
    unitPrice,
    unitDiscount,
    netUnitPrice,
    lineTotal,
    minOrderQty,
    available,
    unavailableReason,
  ];
}
