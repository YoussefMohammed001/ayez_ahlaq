import 'package:equatable/equatable.dart';
import '../../../products/domain/entities/merchant_product.dart';

class SaleTotals extends Equatable {
  final double subtotal;
  final double discount;

  const SaleTotals({required this.subtotal, required this.discount});

  factory SaleTotals.of({
    required List<MerchantProduct> products,
    required Map<int, int> quantities,
    required double discount,
  }) {
    var subtotal = 0.0;
    for (final product in products) {
      subtotal += product.price * (quantities[product.id] ?? 0);
    }
    return SaleTotals(subtotal: subtotal, discount: discount);
  }

  double get total => subtotal - discount;

  bool get discountTooHigh => discount > subtotal;

  @override
  List<Object?> get props => [subtotal, discount];
}
