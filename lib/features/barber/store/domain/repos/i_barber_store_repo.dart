import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/cart_line.dart';
import '../entities/cart_quote.dart';
import '../entities/fulfillment_type.dart';
import '../entities/store_merchant.dart';
import '../entities/store_order.dart';
import '../entities/store_product.dart';

abstract class IBarberStoreRepo {
  Future<Either<Failure, List<StoreMerchant>>> getMerchants();

  Future<Either<Failure, List<StoreProduct>>> getMerchantProducts(
    int merchantId,
  );

  Future<Either<Failure, CartQuote>> quoteCart({
    required int merchantId,
    required FulfillmentType? fulfillmentType,
    required List<CartLine> lines,
  });

  Future<Either<Failure, StoreOrder>> placeOrder({
    required int merchantId,
    required FulfillmentType? fulfillmentType,
    required List<CartLine> lines,
    String? note,
  });

  Future<Either<Failure, List<StoreOrder>>> getOrders();

  Future<Either<Failure, StoreOrder>> getOrderById(int id);

  Future<Either<Failure, Unit>> cancelOrder(int id);
}
