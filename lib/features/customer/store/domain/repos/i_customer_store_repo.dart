import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/shop_storefront.dart';
import '../entities/store_cart.dart';
import '../entities/store_fulfillment_type.dart';
import '../entities/store_order.dart';

abstract class ICustomerStoreRepo {
  Future<Either<Failure, ShopStorefront>> getStorefront(int shopId);

  Future<Either<Failure, StoreCart>> getCart();

  Future<Either<Failure, StoreCart>> putCart(Map<int, int> quantitiesByProductId);

  Future<Either<Failure, StoreOrder>> checkout({
    required StoreFulfillmentType? fulfillmentType,
    required String paymentMethod,
    String? deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
    String? note,
  });

  Future<Either<Failure, List<StoreOrder>>> getOrders();

  Future<Either<Failure, StoreOrder>> getOrder(int id);

  Future<Either<Failure, StoreOrder>> cancelOrder(int id);
}
