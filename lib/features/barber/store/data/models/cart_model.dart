import '../../domain/entities/cart.dart';
import 'cart_line_model.dart';

class CartModel extends Cart {
  const CartModel({
    required super.sellerId,
    required super.sellerName,
    required super.deliveryOffered,
    required super.deliveryFee,
    required super.freeDeliveryOver,
    required super.lines,
    required super.itemCount,
    required super.subtotal,
    required super.checkoutReady,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final lines = (json['lines'] as List?) ?? const [];
    return CartModel(
      sellerId: (json['sellerId'] as num?)?.toInt(),
      sellerName: json['sellerName'] as String?,
      deliveryOffered: json['deliveryOffered'] as bool? ?? false,
      deliveryFee: (json['deliveryFee'] as num?)?.toInt() ?? 0,
      freeDeliveryOver: (json['freeDeliveryOver'] as num?)?.toInt(),
      lines: lines
          .map((e) => CartLineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemCount: (json['itemCount'] as num?)?.toInt() ?? 0,
      subtotal: (json['subtotal'] as num?)?.toInt() ?? 0,
      checkoutReady: json['checkoutReady'] as bool? ?? false,
    );
  }
}
