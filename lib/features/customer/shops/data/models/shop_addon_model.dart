import '../../domain/entities/shop_addon.dart';

class ShopAddonModel extends ShopAddon {
  const ShopAddonModel({
    required super.id,
    required super.name,
    required super.price,
  });

  factory ShopAddonModel.fromJson(Map<String, dynamic> json) {
    return ShopAddonModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
    );
  }
}
