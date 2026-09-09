import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/store_fulfillment_type.dart';
import '../entities/store_order.dart';
import '../repos/i_customer_store_repo.dart';

class CheckoutCartUseCase {
  final ICustomerStoreRepo _repo;

  CheckoutCartUseCase(this._repo);

  Future<Either<Failure, StoreOrder>> call({
    required StoreFulfillmentType? fulfillmentType,
    required String paymentMethod,
    String? deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
    String? note,
  }) => _repo.checkout(
    fulfillmentType: fulfillmentType,
    paymentMethod: paymentMethod,
    deliveryAddress: deliveryAddress,
    deliveryLat: deliveryLat,
    deliveryLng: deliveryLng,
    note: note,
  );
}
