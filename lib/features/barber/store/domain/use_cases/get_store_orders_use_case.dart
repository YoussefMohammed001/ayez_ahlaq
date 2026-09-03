import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/store_order.dart';
import '../repos/i_barber_store_repo.dart';

class GetStoreOrdersUseCase {
  final IBarberStoreRepo _repo;

  GetStoreOrdersUseCase(this._repo);

  Future<Either<Failure, List<StoreOrder>>> call() => _repo.getOrders();
}
