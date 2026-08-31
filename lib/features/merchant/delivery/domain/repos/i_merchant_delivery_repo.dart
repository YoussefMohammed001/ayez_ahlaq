import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/delivery_settings.dart';

abstract class IMerchantDeliveryRepo {
  Future<Either<Failure, DeliverySettings>> getDelivery();

  Future<Either<Failure, DeliverySettings>> updateDelivery(
    DeliverySettings settings,
  );
}
