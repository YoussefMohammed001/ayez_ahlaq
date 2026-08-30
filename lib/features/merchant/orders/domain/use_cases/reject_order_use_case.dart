import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/purchase_order.dart';
import '../repos/i_merchant_orders_repo.dart';

class RejectOrderUseCase {
  final IMerchantOrdersRepo _repo;

  RejectOrderUseCase(this._repo);

  Future<Either<Failure, PurchaseOrder>> call(int id, String reason) =>
      _repo.rejectOrder(id, reason);
}
