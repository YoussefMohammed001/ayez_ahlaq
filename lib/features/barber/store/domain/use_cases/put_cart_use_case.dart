import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/cart.dart';
import '../repos/i_barber_store_repo.dart';

class PutCartUseCase {
  final IBarberStoreRepo _repo;

  PutCartUseCase(this._repo);

  Future<Either<Failure, Cart>> call(Map<int, int> quantitiesByProductId) =>
      _repo.putCart(quantitiesByProductId);
}
