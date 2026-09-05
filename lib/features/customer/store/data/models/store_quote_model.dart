import '../../domain/entities/store_quote.dart';
import 'store_quote_line_model.dart';

class StoreQuoteModel extends StoreQuote {
  const StoreQuoteModel({
    required super.lines,
    required super.subtotal,
    required super.deliveryFee,
    required super.total,
  });

  factory StoreQuoteModel.fromJson(Map<String, dynamic> json) {
    return StoreQuoteModel(
      lines: (json['lines'] as List<dynamic>? ?? [])
          .map((e) => StoreQuoteLineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtotal: (json['subtotal'] as num?)?.toInt() ?? 0,
      deliveryFee: (json['deliveryFee'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
    );
  }
}
