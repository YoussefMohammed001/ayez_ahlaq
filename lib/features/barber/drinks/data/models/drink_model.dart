import '../../domain/entities/drink.dart';

class DrinkModel extends Drink {
  const DrinkModel({
    required super.id,
    required super.name,
    required super.price,
    required super.active,
    required super.sortOrder,
  });

  factory DrinkModel.fromJson(Map<String, dynamic> json) {
    return DrinkModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      active: json['active'] as bool? ?? true,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );
  }
}
