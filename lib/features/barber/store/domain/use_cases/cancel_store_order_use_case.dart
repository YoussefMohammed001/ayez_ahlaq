import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_store_repo.dart';

class CancelStoreOrderUseCase {
  final IBarberStoreRepo _repo;

  CancelStoreOrderUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.cancelOrder(id);
}
