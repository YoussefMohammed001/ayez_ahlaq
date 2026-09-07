import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/purchase_order.dart';
import '../repos/i_merchant_orders_repo.dart';

class GetOrderUseCase {
  final IMerchantOrdersRepo _repo;

  GetOrderUseCase(this._repo);

  Future<Either<Failure, PurchaseOrder>> call(int id) => _repo.getOrder(id);
}
