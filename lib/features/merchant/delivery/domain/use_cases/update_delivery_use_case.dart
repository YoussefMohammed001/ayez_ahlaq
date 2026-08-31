import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/delivery_settings.dart';
import '../repos/i_merchant_delivery_repo.dart';

class UpdateDeliveryUseCase {
  final IMerchantDeliveryRepo _repo;

  UpdateDeliveryUseCase(this._repo);

  Future<Either<Failure, DeliverySettings>> call(DeliverySettings settings) =>
      _repo.updateDelivery(settings);
}
