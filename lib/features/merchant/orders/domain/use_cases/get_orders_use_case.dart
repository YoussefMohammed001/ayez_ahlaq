import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/order_status.dart';
import '../entities/purchase_order.dart';
import '../repos/i_merchant_orders_repo.dart';

class GetOrdersUseCase {
  final IMerchantOrdersRepo _repo;

  GetOrdersUseCase(this._repo);

  Future<Either<Failure, List<PurchaseOrder>>> call({OrderStatus? status}) =>
      _repo.getOrders(status: status);
}
