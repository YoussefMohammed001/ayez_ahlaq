import 'package:equatable/equatable.dart';
import 'sale_line.dart';

class SaleDraft extends Equatable {
  final List<SaleLine> lines;
  final String? customerName;
  final String? customerPhone;
  final String? paymentMethod;
  final double discount;
  final String? note;

  const SaleDraft({
    required this.lines,
    this.customerName,
    this.customerPhone,
    this.paymentMethod,
    this.discount = 0,
    this.note,
  });

  @override
  List<Object?> get props => [
    lines,
    customerName,
    customerPhone,
    paymentMethod,
    discount,
    note,
  ];
}
