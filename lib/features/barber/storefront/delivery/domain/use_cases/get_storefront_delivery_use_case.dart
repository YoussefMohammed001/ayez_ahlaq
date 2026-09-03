import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../entities/storefront_delivery_settings.dart';
import '../repos/i_barber_storefront_delivery_repo.dart';

class GetStorefrontDeliveryUseCase {
  final IBarberStorefrontDeliveryRepo _repo;

  GetStorefrontDeliveryUseCase(this._repo);

  Future<Either<Failure, StorefrontDeliverySettings>> call() =>
      _repo.getDelivery();
}
