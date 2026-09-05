import 'package:equatable/equatable.dart';

class StoreQuoteLine extends Equatable {
  final int productId;
  final String productName;
  final int quantity;
  final int unitPrice;
  final int lineTotal;
  final bool available;
  final String? unavailableReason;

  const StoreQuoteLine({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
    required this.available,
    this.unavailableReason,
  });

  @override
  List<Object?> get props => [
    productId,
    productName,
    quantity,
    unitPrice,
    lineTotal,
    available,
    unavailableReason,
  ];
}
