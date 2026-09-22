import 'package:equatable/equatable.dart';
import 'store_order_item.dart';

class StoreQuote extends Equatable {
  final List<StoreOrderItem> lines;
  final int subtotal;
  final int orderDiscount;
  final int total;
  final int deliveryFee;
  final int grandTotal;
  final int grossSubtotal;
  final int discountTotal;

  const StoreQuote({
    required this.lines,
    required this.subtotal,
    required this.orderDiscount,
    required this.total,
    required this.deliveryFee,
    required this.grandTotal,
    this.grossSubtotal = 0,
    this.discountTotal = 0,
  });

  static const empty = StoreQuote(
    lines: [],
    subtotal: 0,
    orderDiscount: 0,
    total: 0,
    deliveryFee: 0,
    grandTotal: 0,
  );

  bool get hasProductDiscount => discountTotal > 0;

  @override
  List<Object?> get props => [
    lines,
    subtotal,
    orderDiscount,
    total,
    deliveryFee,
    grandTotal,
    grossSubtotal,
    discountTotal,
  ];
}
