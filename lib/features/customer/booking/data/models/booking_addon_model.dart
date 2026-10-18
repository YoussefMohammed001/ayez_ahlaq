import '../../domain/entities/booking_addon.dart';

class BookingAddonModel extends BookingAddon {
  const BookingAddonModel({
    required super.productId,
    required super.quantity,
    super.name,
    super.price,
    super.unitDiscount,
    super.lineTotal,
    super.drinkId,
  });

  factory BookingAddonModel.fromJson(Map<String, dynamic> json) {
    return BookingAddonModel(
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      name: json['productName'] as String?,
      price: (json['unitPrice'] as num?)?.toInt(),
      unitDiscount: (json['unitDiscount'] as num?)?.toInt(),
      lineTotal: (json['lineTotal'] as num?)?.toInt(),
      drinkId: (json['drinkId'] as num?)?.toInt(),
    );
  }
}
