import '../../domain/entities/quote_line.dart';

class QuoteLineModel extends QuoteLine {
  const QuoteLineModel({
    required super.productId,
    required super.productName,
    required super.quantity,
    required super.unitPrice,
    required super.unitDiscount,
    required super.gift,
    required super.lineTotal,
    super.discountId,
  });

  factory QuoteLineModel.fromJson(Map<String, dynamic> json) {
    return QuoteLineModel(
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      productName: json['productName'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toInt() ?? 0,
      unitDiscount: (json['unitDiscount'] as num?)?.toInt() ?? 0,
      gift: json['gift'] as bool? ?? false,
      lineTotal: (json['lineTotal'] as num?)?.toInt() ?? 0,
      discountId: (json['discountId'] as num?)?.toInt(),
    );
  }
}
