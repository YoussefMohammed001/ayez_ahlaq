import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/order_status.dart';
import '../../domain/entities/purchase_order.dart';
import '../../domain/repos/i_merchant_orders_repo.dart';
import '../apis/merchant_orders_api.dart';
import '../models/purchase_order_model.dart';

class MerchantOrdersRepo implements IMerchantOrdersRepo {
  final MerchantOrdersApi _api;

  MerchantOrdersRepo(this._api);

  @override
  Future<Either<Failure, List<PurchaseOrder>>> getOrders({
    OrderStatus? status,
  }) async {
    final result = await _api.getOrders(status: status);
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, PurchaseOrder>> getOrder(int id) async {
    final result = await _api.getOrder(id);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, PurchaseOrder>> acceptOrder(int id) async {
    final result = await _api.acceptOrder(id);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, PurchaseOrder>> rejectOrder(
    int id,
    String reason,
  ) async {
    final result = await _api.rejectOrder(id, reason);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, PurchaseOrder>> advanceStatus(
    int id,
    OrderStatus status,
  ) async {
    final result = await _api.advanceStatus(id, status);
    return result.map(_mapOne);
  }

  List<PurchaseOrder> _mapList(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map<PurchaseOrder>((e) => PurchaseOrderModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  PurchaseOrder _mapOne(dynamic response) {
    return PurchaseOrderModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }
}
