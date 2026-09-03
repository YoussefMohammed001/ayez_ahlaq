import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../../domain/entities/storefront_order.dart';
import '../../domain/entities/storefront_order_status.dart';
import '../../domain/repos/i_barber_storefront_orders_repo.dart';
import '../apis/barber_storefront_orders_api.dart';
import '../models/storefront_order_model.dart';

class BarberStorefrontOrdersRepo implements IBarberStorefrontOrdersRepo {
  final BarberStorefrontOrdersApi _api;

  BarberStorefrontOrdersRepo(this._api);

  @override
  Future<Either<Failure, List<StorefrontOrder>>> getOrders() async {
    final result = await _api.getOrders();
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, StorefrontOrder>> getOrder(int id) async {
    final result = await _api.getOrder(id);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, StorefrontOrder>> acceptOrder(int id) async {
    final result = await _api.acceptOrder(id);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, StorefrontOrder>> rejectOrder(
    int id,
    String reason,
  ) async {
    final result = await _api.rejectOrder(id, reason);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, StorefrontOrder>> advanceStatus(
    int id,
    StorefrontOrderStatus status,
  ) async {
    final result = await _api.advanceStatus(id, status);
    return result.map(_mapOne);
  }

  List<StorefrontOrder> _mapList(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map<StorefrontOrder>(
          (e) => StorefrontOrderModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  StorefrontOrder _mapOne(dynamic response) {
    return StorefrontOrderModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }
}
