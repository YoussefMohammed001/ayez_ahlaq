import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../entities/storefront_order.dart';
import '../entities/storefront_order_status.dart';

abstract class IBarberStorefrontOrdersRepo {
  Future<Either<Failure, List<StorefrontOrder>>> getOrders();

  Future<Either<Failure, StorefrontOrder>> getOrder(int id);

  Future<Either<Failure, StorefrontOrder>> acceptOrder(int id);

  Future<Either<Failure, StorefrontOrder>> rejectOrder(int id, String reason);

  Future<Either<Failure, StorefrontOrder>> advanceStatus(
    int id,
    StorefrontOrderStatus status,
  );
}
