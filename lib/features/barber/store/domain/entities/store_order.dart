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
  final DateTime? acceptedAt;
  final DateTime? rejectedAt;
  final DateTime? deliveredAt;
  final String? deliveryAddress;
  final double? deliveryLat;
  final double? deliveryLng;

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
    this.acceptedAt,
    this.rejectedAt,
    this.deliveredAt,
    this.deliveryAddress,
    this.deliveryLat,
    this.deliveryLng,
  });

  bool get hasDeliveryFee => deliveryFee > 0;

  int get preDiscountTotal => total + orderDiscount;

  int? get orderDiscountPercent => preDiscountTotal > 0
      ? ((orderDiscount / preDiscountTotal) * 100).round()
      : null;

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
      acceptedAt: acceptedAt,
      rejectedAt: rejectedAt,
      deliveredAt: deliveredAt,
      deliveryAddress: deliveryAddress,
      deliveryLat: deliveryLat,
      deliveryLng: deliveryLng,
    );
  }

  @override
  List<Object?> get props => [
    id,
    code,
    status,
    merchantId,
    merchantName,
    fulfillmentType,
    note,
    rejectionReason,
    total,
    orderDiscount,
    deliveryFee,
    grandTotal,
    items,
    orderDate,
    acceptedAt,
    rejectedAt,
    deliveredAt,
    deliveryAddress,
    deliveryLat,
    deliveryLng,
  ];
}
