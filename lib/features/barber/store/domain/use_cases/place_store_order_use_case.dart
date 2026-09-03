import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/cart_line.dart';
import '../entities/fulfillment_type.dart';
import '../entities/store_order.dart';
import '../repos/i_barber_store_repo.dart';

class PlaceStoreOrderUseCase {
  final IBarberStoreRepo _repo;

  PlaceStoreOrderUseCase(this._repo);

  Future<Either<Failure, StoreOrder>> call({
    required int merchantId,
    required FulfillmentType? fulfillmentType,
    required List<CartLine> lines,
    String? note,
  }) => _repo.placeOrder(
    merchantId: merchantId,
    fulfillmentType: fulfillmentType,
    lines: lines,
    note: note,
  );
}
