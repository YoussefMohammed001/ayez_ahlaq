import '../../domain/entities/discount_quote.dart';
import 'applied_discount_model.dart';
import 'quote_line_model.dart';

class DiscountQuoteModel extends DiscountQuote {
  const DiscountQuoteModel({
    required super.lines,
    required super.subtotal,
    required super.orderDiscount,
    required super.total,
    required super.applied,
  });

  factory DiscountQuoteModel.fromJson(Map<String, dynamic> json) {
    return DiscountQuoteModel(
      lines: (json['lines'] as List<dynamic>? ?? [])
          .map((e) => QuoteLineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtotal: (json['subtotal'] as num?)?.toInt() ?? 0,
      orderDiscount: (json['orderDiscount'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      applied: (json['applied'] as List<dynamic>? ?? [])
          .map((e) => AppliedDiscountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
