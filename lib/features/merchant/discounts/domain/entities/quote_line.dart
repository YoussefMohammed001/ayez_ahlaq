import 'package:equatable/equatable.dart';

class QuoteLine extends Equatable {
  final int productId;
  final String productName;
  final int quantity;
  final int unitPrice;
  final int unitDiscount;
  final bool gift;
  final int? discountId;
  final int lineTotal;

  const QuoteLine({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.unitDiscount,
    required this.gift,
    required this.lineTotal,
    this.discountId,
  });

  bool get hasDiscount => unitDiscount > 0;

  int get effectiveUnitPrice => unitPrice - unitDiscount;

  int get grossTotal => unitPrice * quantity;

  int? get unitDiscountPercent =>
      unitPrice > 0 ? ((unitDiscount / unitPrice) * 100).round() : null;

  @override
  List<Object?> get props => [
    productId,
    productName,
    quantity,
    unitPrice,
    unitDiscount,
    gift,
    discountId,
    lineTotal,
  ];
}
