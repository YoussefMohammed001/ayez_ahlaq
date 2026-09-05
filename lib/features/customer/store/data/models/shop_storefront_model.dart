import '../../domain/entities/shop_storefront.dart';
import 'store_category_model.dart';
import 'store_delivery_model.dart';
import 'store_product_model.dart';

class ShopStorefrontModel extends ShopStorefront {
  const ShopStorefrontModel({
    required super.shopName,
    required super.delivery,
    required super.categories,
    required super.products,
  });

  factory ShopStorefrontModel.fromJson(Map<String, dynamic> json) {
    return ShopStorefrontModel(
      shopName: json['shopName'] as String? ?? '',
      delivery: StoreDeliveryModel.fromJson(
        json['delivery'] as Map<String, dynamic>? ?? {},
      ),
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((e) => StoreCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>? ?? [])
          .map((e) => StoreProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
