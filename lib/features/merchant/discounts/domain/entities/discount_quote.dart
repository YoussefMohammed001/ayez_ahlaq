import 'package:equatable/equatable.dart';
import 'applied_discount.dart';
import 'quote_line.dart';

class DiscountQuote extends Equatable {
  final List<QuoteLine> lines;
  final int subtotal;
  final int orderDiscount;
  final int total;
  final List<AppliedDiscount> applied;

  const DiscountQuote({
    required this.lines,
    required this.subtotal,
    required this.orderDiscount,
    required this.total,
    required this.applied,
  });

  int get grossTotal => lines.fold(0, (s, l) => s + l.grossTotal);

  int get savings => grossTotal - total;

  bool get hasProductDiscount => grossTotal > subtotal;

  @override
  List<Object?> get props => [lines, subtotal, orderDiscount, total, applied];
}
