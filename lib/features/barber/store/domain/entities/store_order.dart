import 'package:equatable/equatable.dart';
import 'fulfillment_type.dart';
import 'store_order_item.dart';
import 'store_order_status.dart';

class StoreOrder extends Equatable {
  final int id;
  final String code;
  final StoreOrderStatus status;
  final int merchantId;
  final String merchantName;
  final FulfillmentType fulfillmentType;
  final String? note;
  final String? rejectionReason;
  final int total;
  final int orderDiscount;
  final int deliveryFee;
  final int grandTotal;
  final List<StoreOrderItem> items;
  final DateTime? orderDate;

  const StoreOrder({
    required this.id,
    required this.code,
    required this.status,
    required this.merchantId,
    required this.merchantName,
    required this.fulfillmentType,
    required this.total,
    required this.orderDiscount,
    required this.deliveryFee,
    required this.grandTotal,
    required this.items,
    this.note,
    this.rejectionReason,
    this.orderDate,
  });

  bool get hasDeliveryFee => deliveryFee > 0;

  StoreOrder copyWith({StoreOrderStatus? status}) {
    return StoreOrder(
      id: id,
      code: code,
      status: status ?? this.status,
      merchantId: merchantId,
      merchantName: merchantName,
      fulfillmentType: fulfillmentType,
      total: total,
      orderDiscount: orderDiscount,
      deliveryFee: deliveryFee,
      grandTotal: grandTotal,
      items: items,
      note: note,
      rejectionReason: rejectionReason,
      orderDate: orderDate,
    );
  }

  @override
  List<Object?> get props => [id, code, status, total, grandTotal];
}
