import '../../domain/entities/shop_haircut_style.dart';

class ShopHaircutStyleModel extends ShopHaircutStyle {
  const ShopHaircutStyleModel({
    required super.id,
    required super.name,
    required super.serviceTypeId,
    required super.priceDelta,
    required super.active,
  });

  factory ShopHaircutStyleModel.fromJson(Map<String, dynamic> json) {
    return ShopHaircutStyleModel(
      id: (json['haircutStyleId'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      serviceTypeId: (json['serviceTypeId'] as num?)?.toInt() ?? 0,
      priceDelta: (json['priceDelta'] as num?)?.toInt() ?? 0,
      active: json['active'] as bool? ?? false,
    );
  }
}
