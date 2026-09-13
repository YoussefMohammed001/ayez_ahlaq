import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/fulfillment_type.dart';
import '../entities/store_order.dart';
import '../repos/i_barber_store_repo.dart';

class CheckoutCartUseCase {
  final IBarberStoreRepo _repo;

  CheckoutCartUseCase(this._repo);

  Future<Either<Failure, (StoreOrder, String)>> call({
    required FulfillmentType? fulfillmentType,
    String? deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
    String? note,
  }) => _repo.checkout(
    fulfillmentType: fulfillmentType,
    deliveryAddress: deliveryAddress,
    deliveryLat: deliveryLat,
    deliveryLng: deliveryLng,
    note: note,
  );
}
