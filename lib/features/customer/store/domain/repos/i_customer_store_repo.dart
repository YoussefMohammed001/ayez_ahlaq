import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/shop_storefront.dart';
import '../entities/store_fulfillment_type.dart';
import '../entities/store_order.dart';
import '../entities/store_quote.dart';

abstract class ICustomerStoreRepo {
  Future<Either<Failure, ShopStorefront>> getStorefront(int shopId);

  Future<Either<Failure, StoreQuote>> quoteCart({
    required int shopId,
    required StoreFulfillmentType fulfillmentType,
    required Map<int, int> items,
  });

  Future<Either<Failure, StoreOrder>> placeOrder({
    required int shopId,
    required StoreFulfillmentType fulfillmentType,
    required String paymentMethod,
    String? note,
    required Map<int, int> items,
  });

  Future<Either<Failure, List<StoreOrder>>> getOrders();

  Future<Either<Failure, StoreOrder>> getOrder(int id);

  Future<Either<Failure, StoreOrder>> cancelOrder(int id);
}
