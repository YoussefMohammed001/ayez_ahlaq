import '../../domain/entities/store_quote_line.dart';

class StoreQuoteLineModel extends StoreQuoteLine {
  const StoreQuoteLineModel({
    required super.productId,
    required super.productName,
    required super.quantity,
    required super.unitPrice,
    required super.lineTotal,
    required super.available,
    super.unavailableReason,
  });

  factory StoreQuoteLineModel.fromJson(Map<String, dynamic> json) {
    return StoreQuoteLineModel(
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      productName: json['productName'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toInt() ?? 0,
      lineTotal: (json['lineTotal'] as num?)?.toInt() ?? 0,
      available: json['available'] as bool? ?? true,
      unavailableReason: json['unavailableReason'] as String?,
    );
  }
}
