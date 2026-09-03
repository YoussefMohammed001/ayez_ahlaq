import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../entities/storefront_delivery_settings.dart';

abstract class IBarberStorefrontDeliveryRepo {
  Future<Either<Failure, StorefrontDeliverySettings>> getDelivery();

  Future<Either<Failure, StorefrontDeliverySettings>> updateDelivery(
    StorefrontDeliverySettings settings,
  );
}
