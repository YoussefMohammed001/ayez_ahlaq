import 'package:equatable/equatable.dart';
import 'active_discount.dart';
import 'product_image_source.dart';

class MerchantProduct extends Equatable {
  final int id;
  final String name;
  final String? brand;
  final int? categoryId;
  final String? categoryName;
  final String? description;
  final int price;
  final int effectivePrice;
  final int minOrderQty;
  final bool active;
  final int totalStock;
  final ActiveDiscount? activeDiscount;
  final ProductImageSource imageSource;
  final List<int> imageIds;

  const MerchantProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.effectivePrice,
    required this.minOrderQty,
    required this.active,
    required this.totalStock,
    required this.imageSource,
    required this.imageIds,
    this.brand,
    this.categoryId,
    this.categoryName,
    this.description,
    this.activeDiscount,
  });

  bool get hasDiscount => effectivePrice < price;

  bool get isOutOfStock => totalStock <= 0;

  MerchantProduct copyWith({bool? active, int? totalStock}) {
    return MerchantProduct(
      id: id,
      name: name,
      brand: brand,
      categoryId: categoryId,
      categoryName: categoryName,
      description: description,
      price: price,
      effectivePrice: effectivePrice,
      minOrderQty: minOrderQty,
      active: active ?? this.active,
      totalStock: totalStock ?? this.totalStock,
      activeDiscount: activeDiscount,
      imageSource: imageSource,
      imageIds: imageIds,
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
    effectivePrice,
    minOrderQty,
    active,
    totalStock,
    activeDiscount,
    imageSource,
    imageIds,
  ];
}
