import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  final int productId;
  final String productName;
  final int quantity;
  final int unitPrice;
  final int unitDiscount;
  final int lineTotal;
  final bool gift;
  final int? currentEffectivePrice;
  final bool priceChangedSinceOrder;

  const OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.unitDiscount,
    required this.lineTotal,
    this.gift = false,
    this.currentEffectivePrice,
    this.priceChangedSinceOrder = false,
  });

  @override
  List<Object?> get props => [productId, quantity, lineTotal, gift];
}
