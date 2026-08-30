import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/order_status.dart';
import '../entities/purchase_order.dart';

abstract class IMerchantOrdersRepo {
  Future<Either<Failure, List<PurchaseOrder>>> getOrders({OrderStatus? status});

  Future<Either<Failure, PurchaseOrder>> getOrder(int id);

  Future<Either<Failure, PurchaseOrder>> acceptOrder(int id);

  Future<Either<Failure, PurchaseOrder>> rejectOrder(int id, String reason);

  Future<Either<Failure, PurchaseOrder>> advanceStatus(
    int id,
    OrderStatus status,
  );
}
