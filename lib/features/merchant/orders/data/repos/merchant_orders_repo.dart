import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/order_status.dart';
import '../../domain/entities/purchase_order.dart';
import '../../domain/repos/i_merchant_orders_repo.dart';
import '../apis/merchant_orders_api.dart';
import '../local/merchant_orders_mock.dart';
import '../models/purchase_order_model.dart';

class MerchantOrdersRepo implements IMerchantOrdersRepo {
  final MerchantOrdersApi _api;

  MerchantOrdersRepo(this._api);

  @override
  Future<Either<Failure, List<PurchaseOrder>>> getOrders({
    OrderStatus? status,
  }) async {
    if (MerchantOrdersMock.enabled) {
      return Right(_mockOrders(status));
    }

    final result = await _api.getOrders(status: status);
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, PurchaseOrder>> getOrder(int id) async {
    if (MerchantOrdersMock.enabled) {
      return Right(_mockOrders(null).firstWhere((o) => o.id == id));
    }

    final result = await _api.getOrder(id);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, PurchaseOrder>> acceptOrder(int id) async {
    if (MerchantOrdersMock.enabled) {
      return Right(_mockTransition(id, OrderStatus.accepted));
    }

    final result = await _api.acceptOrder(id);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, PurchaseOrder>> rejectOrder(
    int id,
    String reason,
  ) async {
    if (MerchantOrdersMock.enabled) {
      return Right(_mockTransition(id, OrderStatus.rejected));
    }

    final result = await _api.rejectOrder(id, reason);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, PurchaseOrder>> advanceStatus(
    int id,
    OrderStatus status,
  ) async {
    if (MerchantOrdersMock.enabled) {
      return Right(_mockTransition(id, status));
    }

    final result = await _api.advanceStatus(id, status);
    return result.map(_mapOne);
  }

  List<PurchaseOrder> _mockOrders(OrderStatus? status) {
    final all = MerchantOrdersMock.orders()
        .map<PurchaseOrder>(PurchaseOrderModel.fromJson)
        .toList();
    if (status == null) return all;
    return all.where((o) => o.status == status).toList();
  }

  PurchaseOrder _mockTransition(int id, OrderStatus status) {
    final order = _mockOrders(null).firstWhere((o) => o.id == id);
    return order.copyWith(
      status: status,
      nextStatuses: _mockNextStatuses(status, order),
    );
  }

  List<OrderStatus> _mockNextStatuses(OrderStatus status, PurchaseOrder order) {
    return switch (status) {
      OrderStatus.accepted => [OrderStatus.preparing],
      OrderStatus.preparing => [
        if (order.fulfilmentType.name == 'pickupAtBranch')
          OrderStatus.readyForPickup
        else
          OrderStatus.outForDelivery,
      ],
      OrderStatus.readyForPickup ||
      OrderStatus.outForDelivery => [OrderStatus.delivered],
      _ => const [],
    };
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
