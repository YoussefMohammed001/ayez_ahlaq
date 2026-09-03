import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../entities/storefront_delivery_settings.dart';
import '../repos/i_barber_storefront_delivery_repo.dart';

class UpdateStorefrontDeliveryUseCase {
  final IBarberStorefrontDeliveryRepo _repo;

  UpdateStorefrontDeliveryUseCase(this._repo);

  Future<Either<Failure, StorefrontDeliverySettings>> call(
    StorefrontDeliverySettings settings,
  ) => _repo.updateDelivery(settings);
}
