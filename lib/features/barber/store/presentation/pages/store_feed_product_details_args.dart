import '../../domain/entities/store_feed_product.dart';
import '../../domain/entities/store_merchant.dart';

class StoreFeedProductDetailsArgs {
  final StoreFeedProduct product;
  final StoreMerchant? merchant;

  const StoreFeedProductDetailsArgs({required this.product, this.merchant});
}
