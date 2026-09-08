import '../../domain/entities/shop_drink.dart';

class ShopDrinkModel extends ShopDrink {
  const ShopDrinkModel({
    required super.id,
    required super.name,
    required super.price,
  });

  factory ShopDrinkModel.fromJson(Map<String, dynamic> json) {
    return ShopDrinkModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
    );
  }
}
