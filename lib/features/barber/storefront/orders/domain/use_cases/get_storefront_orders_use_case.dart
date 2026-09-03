import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../entities/storefront_order.dart';
import '../repos/i_barber_storefront_orders_repo.dart';

class GetStorefrontOrdersUseCase {
  final IBarberStorefrontOrdersRepo _repo;

  GetStorefrontOrdersUseCase(this._repo);

  Future<Either<Failure, List<StorefrontOrder>>> call() => _repo.getOrders();
}
