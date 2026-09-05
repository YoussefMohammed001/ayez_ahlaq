import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/store_order.dart';
import '../repos/i_customer_store_repo.dart';

class CancelStoreOrderUseCase {
  final ICustomerStoreRepo _repo;

  CancelStoreOrderUseCase(this._repo);

  Future<Either<Failure, StoreOrder>> call(int id) => _repo.cancelOrder(id);
}
