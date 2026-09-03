import 'package:equatable/equatable.dart';

class StorefrontProduct extends Equatable {
  final int id;
  final String name;
  final String? brand;
  final int? categoryId;
  final String? categoryName;
  final String? description;
  final int price;
  final int minOrderQty;
  final bool active;
  final int stock;
  final bool hasImage;

  const StorefrontProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.minOrderQty,
    required this.active,
    required this.stock,
    required this.hasImage,
    this.brand,
    this.categoryId,
    this.categoryName,
    this.description,
  });

  bool get isOutOfStock => stock <= 0;

  StorefrontProduct copyWith({bool? active, int? stock}) {
    return StorefrontProduct(
      id: id,
      name: name,
      brand: brand,
      categoryId: categoryId,
      categoryName: categoryName,
      description: description,
      price: price,
      minOrderQty: minOrderQty,
      active: active ?? this.active,
      stock: stock ?? this.stock,
      hasImage: hasImage,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    brand,
    categoryId,
    categoryName,
    description,
    price,
    minOrderQty,
    active,
    stock,
    hasImage,
  ];
}
