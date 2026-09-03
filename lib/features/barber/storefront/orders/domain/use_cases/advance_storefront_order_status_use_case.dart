import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../entities/storefront_order.dart';
import '../entities/storefront_order_status.dart';
import '../repos/i_barber_storefront_orders_repo.dart';

class AdvanceStorefrontOrderStatusUseCase {
  final IBarberStorefrontOrdersRepo _repo;

  AdvanceStorefrontOrderStatusUseCase(this._repo);

  Future<Either<Failure, StorefrontOrder>> call(
    int id,
    StorefrontOrderStatus status,
  ) => _repo.advanceStatus(id, status);
}
