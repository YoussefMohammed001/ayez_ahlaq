import 'package:equatable/equatable.dart';

class StoreProduct extends Equatable {
  final int id;
  final String name;
  final String brand;
  final String categoryName;
  final int price;
  final int effectivePrice;
  final int minOrderQty;

  const StoreProduct({
    required this.id,
    required this.name,
    required this.brand,
    required this.categoryName,
    required this.price,
    required this.effectivePrice,
    required this.minOrderQty,
  });

  bool get isDiscounted => effectivePrice < price;

  @override
  List<Object?> get props => [id, name, brand, categoryName, price, effectivePrice, minOrderQty];
}
