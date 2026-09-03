import '../../domain/entities/cart_quote.dart';

class CartQuoteModel extends CartQuote {
  const CartQuoteModel({
    required super.subtotal,
    required super.deliveryFee,
    required super.total,
  });

  factory CartQuoteModel.fromJson(Map<String, dynamic> json) {
    final subtotal = (json['subtotal'] as num?)?.toInt() ?? 0;
    final total = (json['total'] as num?)?.toInt() ?? subtotal;
    return CartQuoteModel(
      subtotal: subtotal,
      deliveryFee: (json['deliveryFee'] as num?)?.toInt() ?? 0,
      total: (json['grandTotal'] as num?)?.toInt() ?? total,
    );
  }
}
