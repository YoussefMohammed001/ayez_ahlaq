import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../entities/storefront_order.dart';
import '../repos/i_barber_storefront_orders_repo.dart';

class GetStorefrontOrderUseCase {
  final IBarberStorefrontOrdersRepo _repo;

  GetStorefrontOrderUseCase(this._repo);

  Future<Either<Failure, StorefrontOrder>> call(int id) => _repo.getOrder(id);
}
