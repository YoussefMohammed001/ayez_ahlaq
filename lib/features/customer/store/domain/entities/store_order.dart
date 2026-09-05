import 'package:equatable/equatable.dart';
import 'store_fulfillment_type.dart';
import 'store_order_status.dart';
import 'store_quote_line.dart';

class StoreOrder extends Equatable {
  final int id;
  final String code;
  final StoreOrderStatus status;
  final int shopId;
  final String shopName;
  final StoreFulfillmentType fulfillmentType;
  final String paymentMethod;
  final int subtotal;
  final int deliveryFee;
  final int total;
  final List<StoreQuoteLine> items;
  final String? note;
  final DateTime? createdAt;
  final String? rejectionReason;

  const StoreOrder({
    required this.id,
    required this.code,
    required this.status,
    required this.shopId,
    required this.shopName,
    required this.fulfillmentType,
    required this.paymentMethod,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.items,
    this.note,
    this.createdAt,
    this.rejectionReason,
  });

  StoreOrder copyWith({StoreOrderStatus? status}) {
    return StoreOrder(
      id: id,
      code: code,
      status: status ?? this.status,
      shopId: shopId,
      shopName: shopName,
      fulfillmentType: fulfillmentType,
      paymentMethod: paymentMethod,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: total,
      items: items,
      note: note,
      createdAt: createdAt,
      rejectionReason: rejectionReason,
    );
  }

  @override
  List<Object?> get props => [id, code, status, total];
}
