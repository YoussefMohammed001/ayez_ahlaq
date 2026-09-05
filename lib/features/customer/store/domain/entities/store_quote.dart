import 'package:equatable/equatable.dart';
import 'store_quote_line.dart';

class StoreQuote extends Equatable {
  final List<StoreQuoteLine> lines;
  final int subtotal;
  final int deliveryFee;
  final int total;

  const StoreQuote({
    required this.lines,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  @override
  List<Object?> get props => [lines, subtotal, deliveryFee, total];
}
