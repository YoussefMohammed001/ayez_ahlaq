import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/delivery_settings.dart';
import '../repos/i_merchant_delivery_repo.dart';

class GetDeliveryUseCase {
  final IMerchantDeliveryRepo _repo;

  GetDeliveryUseCase(this._repo);

  Future<Either<Failure, DeliverySettings>> call() => _repo.getDelivery();
}
