import '../../domain/entities/booking_addon.dart';

class BookingAddonModel extends BookingAddon {
  const BookingAddonModel({
    required super.productId,
    required super.quantity,
    super.name,
    super.price,
  });

  factory BookingAddonModel.fromJson(Map<String, dynamic> json) {
    return BookingAddonModel(
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toInt(),
    );
  }
}
