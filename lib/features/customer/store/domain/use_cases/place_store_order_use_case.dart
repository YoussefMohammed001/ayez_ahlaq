import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/store_fulfillment_type.dart';
import '../entities/store_order.dart';
import '../repos/i_customer_store_repo.dart';

class PlaceStoreOrderUseCase {
  final ICustomerStoreRepo _repo;

  PlaceStoreOrderUseCase(this._repo);

  Future<Either<Failure, StoreOrder>> call({
    required int shopId,
    required StoreFulfillmentType fulfillmentType,
    required String paymentMethod,
    String? note,
    required Map<int, int> items,
  }) => _repo.placeOrder(
    shopId: shopId,
    fulfillmentType: fulfillmentType,
    paymentMethod: paymentMethod,
    note: note,
    items: items,
  );
}
