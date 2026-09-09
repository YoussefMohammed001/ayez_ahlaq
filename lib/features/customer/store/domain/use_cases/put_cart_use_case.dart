import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/store_cart.dart';
import '../repos/i_customer_store_repo.dart';

class PutCartUseCase {
  final ICustomerStoreRepo _repo;

  PutCartUseCase(this._repo);

  Future<Either<Failure, StoreCart>> call(Map<int, int> quantitiesByProductId) =>
      _repo.putCart(quantitiesByProductId);
}
