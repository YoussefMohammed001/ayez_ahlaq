import '../../domain/entities/discount_shop.dart';

class DiscountShopModel extends DiscountShop {
  const DiscountShopModel({
    required super.id,
    required super.name,
    super.area,
  });

  factory DiscountShopModel.fromJson(Map<String, dynamic> json) {
    return DiscountShopModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      area: json['area'] as String?,
    );
  }
}
