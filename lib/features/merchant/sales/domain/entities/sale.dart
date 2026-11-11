import 'package:equatable/equatable.dart';
import 'sale_item.dart';
import 'sale_status.dart';

class Sale extends Equatable {
  final int id;
  final String code;
  final int? soldByMemberId;
  final String? soldByName;
  final String? customerName;
  final String? customerPhone;
  final String? paymentMethod;
  final double subtotal;
  final double discount;
  final double total;
  final SaleStatus status;
  final String? note;
  final DateTime? createdAt;
  final DateTime? cancelledAt;
  final List<SaleItem> items;

  const Sale({
    required this.id,
    required this.code,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.status,
    required this.items,
    this.soldByMemberId,
    this.soldByName,
    this.customerName,
    this.customerPhone,
    this.paymentMethod,
    this.note,
    this.createdAt,
    this.cancelledAt,
  });

  bool get isCancelled => status == SaleStatus.cancelled;

  bool get soldByMember => soldByMemberId != null;

  @override
  List<Object?> get props => [
    id,
    code,
    soldByMemberId,
    soldByName,
    customerName,
    customerPhone,
    paymentMethod,
    subtotal,
    discount,
    total,
    status,
    note,
    createdAt,
    cancelledAt,
    items,
  ];
}
