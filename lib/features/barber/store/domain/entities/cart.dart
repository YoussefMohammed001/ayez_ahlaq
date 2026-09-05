import 'package:equatable/equatable.dart';
import 'cart_line.dart';

class Cart extends Equatable {
  final int? sellerId;
  final String? sellerName;
  final bool deliveryOffered;
  final int deliveryFee;
  final int? freeDeliveryOver;
  final List<CartLine> lines;
  final int itemCount;
  final int subtotal;
  final bool checkoutReady;

  const Cart({
    required this.sellerId,
    required this.sellerName,
    required this.deliveryOffered,
    required this.deliveryFee,
    required this.freeDeliveryOver,
    required this.lines,
    required this.itemCount,
    required this.subtotal,
    required this.checkoutReady,
  });

  static const empty = Cart(
    sellerId: null,
    sellerName: null,
    deliveryOffered: false,
    deliveryFee: 0,
    freeDeliveryOver: null,
    lines: [],
    itemCount: 0,
    subtotal: 0,
    checkoutReady: false,
  );

  bool get isEmpty => lines.isEmpty;

  @override
  List<Object?> get props => [
    sellerId,
    sellerName,
    deliveryOffered,
    deliveryFee,
    freeDeliveryOver,
    lines,
    itemCount,
    subtotal,
    checkoutReady,
  ];
}
