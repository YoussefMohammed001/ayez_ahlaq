import 'package:equatable/equatable.dart';

class StoreProduct extends Equatable {
  final int id;
  final String name;
  final String? brand;
  final int? categoryId;
  final String? categoryName;
  final String? description;
  final int price;
  final int effectivePrice;
  final int minOrderQty;
  final int stock;
  final bool hasImage;

  const StoreProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.effectivePrice,
    required this.minOrderQty,
    required this.stock,
    required this.hasImage,
    this.brand,
    this.categoryId,
    this.categoryName,
    this.description,
  });

  bool get isOutOfStock => stock <= 0;

  bool get isDiscounted => effectivePrice < price;

  int get discountPercent =>
      price <= 0 ? 0 : (((price - effectivePrice) / price) * 100).round();

  @override
  List<Object?> get props => [
    id,
    name,
    brand,
    categoryId,
    categoryName,
    description,
    price,
    effectivePrice,
    minOrderQty,
    stock,
    hasImage,
  ];
}
