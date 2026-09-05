import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/cart.dart';
import '../repos/i_barber_store_repo.dart';

class GetCartUseCase {
  final IBarberStoreRepo _repo;

  GetCartUseCase(this._repo);

  Future<Either<Failure, Cart>> call() => _repo.getCart();
}
