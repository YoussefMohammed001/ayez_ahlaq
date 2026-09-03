import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/store_order.dart';
import '../repos/i_barber_store_repo.dart';

class GetStoreOrderUseCase {
  final IBarberStoreRepo _repo;

  GetStoreOrderUseCase(this._repo);

  Future<Either<Failure, StoreOrder>> call(int id) => _repo.getOrderById(id);
}
