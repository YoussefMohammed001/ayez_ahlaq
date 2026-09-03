import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../entities/storefront_order.dart';
import '../repos/i_barber_storefront_orders_repo.dart';

class RejectStorefrontOrderUseCase {
  final IBarberStorefrontOrdersRepo _repo;

  RejectStorefrontOrderUseCase(this._repo);

  Future<Either<Failure, StorefrontOrder>> call(int id, String reason) =>
      _repo.rejectOrder(id, reason);
}
