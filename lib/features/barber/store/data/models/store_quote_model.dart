import '../../domain/entities/store_quote.dart';
import 'store_order_item_model.dart';

class StoreQuoteModel extends StoreQuote {
  const StoreQuoteModel({
    required super.lines,
    required super.subtotal,
    required super.orderDiscount,
    required super.total,
    required super.deliveryFee,
    required super.grandTotal,
  });

  factory StoreQuoteModel.fromJson(Map<String, dynamic> json) {
    final lines = json['lines'] as List? ?? const [];
    return StoreQuoteModel(
      lines: lines
          .map((e) => StoreOrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtotal: (json['subtotal'] as num?)?.toInt() ?? 0,
      orderDiscount: (json['orderDiscount'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      deliveryFee: (json['deliveryFee'] as num?)?.toInt() ?? 0,
      grandTotal: (json['grandTotal'] as num?)?.toInt() ?? 0,
    );
  }
}
