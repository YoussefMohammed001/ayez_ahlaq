import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/store_cart.dart';
import '../repos/i_customer_store_repo.dart';

class GetCartUseCase {
  final ICustomerStoreRepo _repo;

  GetCartUseCase(this._repo);

  Future<Either<Failure, StoreCart>> call() => _repo.getCart();
}
