import 'package:equatable/equatable.dart';
import 'store_product.dart';

class StoreFeedProduct extends Equatable {
  final StoreProduct product;
  final int shopId;
  final String shopName;

  const StoreFeedProduct({
    required this.product,
    required this.shopId,
    required this.shopName,
  });

  @override
  List<Object?> get props => [product, shopId, shopName];
}
