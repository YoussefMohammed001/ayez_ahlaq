import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/order_status.dart';
import '../entities/purchase_order.dart';
import '../repos/i_merchant_orders_repo.dart';

class AdvanceOrderStatusUseCase {
  final IMerchantOrdersRepo _repo;

  AdvanceOrderStatusUseCase(this._repo);

  Future<Either<Failure, PurchaseOrder>> call(int id, OrderStatus status) =>
      _repo.advanceStatus(id, status);
}
