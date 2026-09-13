import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/cart.dart';
import '../entities/fulfillment_type.dart';
import '../entities/store_merchant.dart';
import '../entities/store_order.dart';
import '../entities/store_product.dart';
import '../entities/store_quote.dart';

abstract class IBarberStoreRepo {
  Future<Either<Failure, List<StoreMerchant>>> getMerchants();

  Future<Either<Failure, List<StoreProduct>>> getMerchantProducts(
    int merchantId,
  );

  Future<Either<Failure, Cart>> getCart();

  Future<Either<Failure, Cart>> putCart(Map<int, int> quantitiesByProductId);

  Future<Either<Failure, StoreQuote>> getQuote({
    required int merchantId,
    required Map<int, int> quantitiesByProductId,
    FulfillmentType? fulfillmentType,
  });

  Future<Either<Failure, (StoreOrder, String)>> checkout({
    required FulfillmentType? fulfillmentType,
    String? deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
    String? note,
  });

  Future<Either<Failure, List<StoreOrder>>> getOrders();

  Future<Either<Failure, StoreOrder>> getOrderById(int id);

  Future<Either<Failure, Unit>> cancelOrder(int id);
}
