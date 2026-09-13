import 'package:equatable/equatable.dart';
import 'store_category.dart';
import 'store_delivery.dart';
import 'store_product.dart';

class ShopStorefront extends Equatable {
  final int shopId;
  final String shopName;
  final StoreDelivery delivery;
  final List<StoreCategory> categories;
  final List<StoreProduct> products;

  const ShopStorefront({
    required this.shopId,
    required this.shopName,
    required this.delivery,
    required this.categories,
    required this.products,
  });

  @override
  List<Object?> get props => [shopId, shopName, delivery, categories, products];
}
