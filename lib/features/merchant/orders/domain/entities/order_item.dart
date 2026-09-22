import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  final int productId;
  final String productName;
  final int quantity;
  final int unitPrice;
  final int unitDiscount;
  final int lineTotal;
  final bool gift;
  final int? discountId;
  final int? currentUnitPrice;
  final int? currentUnitDiscount;
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
    this.discountId,
    this.currentUnitPrice,
    this.currentUnitDiscount,
    this.currentEffectivePrice,
    this.priceChangedSinceOrder = false,
  });

  bool get hasUnitDiscount => unitDiscount > 0;

  int get effectiveUnitPrice => unitPrice - unitDiscount;

  int? get unitDiscountPercent =>
      unitPrice > 0 ? ((unitDiscount / unitPrice) * 100).round() : null;

  bool get basePriceChangedSinceOrder =>
      priceChangedSinceOrder &&
      currentUnitPrice != null &&
      currentUnitPrice != unitPrice;

  bool get newDiscountAppliedSinceOrder =>
      priceChangedSinceOrder &&
      !hasUnitDiscount &&
      (currentUnitDiscount ?? 0) > 0;

  int? get currentUnitDiscountPercent {
    final price = currentUnitPrice;
    final discount = currentUnitDiscount;
    if (price == null || discount == null || price <= 0) return null;
    return ((discount / price) * 100).round();
  }

  @override
  List<Object?> get props => [
    productId,
    productName,
    quantity,
    unitPrice,
    unitDiscount,
    lineTotal,
    gift,
    discountId,
    currentUnitPrice,
    currentUnitDiscount,
    currentEffectivePrice,
    priceChangedSinceOrder,
  ];
}
