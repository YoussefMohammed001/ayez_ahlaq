import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../entities/storefront_order.dart';
import '../repos/i_barber_storefront_orders_repo.dart';

class AcceptStorefrontOrderUseCase {
  final IBarberStorefrontOrdersRepo _repo;

  AcceptStorefrontOrderUseCase(this._repo);

  Future<Either<Failure, StorefrontOrder>> call(int id) =>
      _repo.acceptOrder(id);
}
