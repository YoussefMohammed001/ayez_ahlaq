import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/shop_storefront.dart';
import '../../domain/entities/store_cart.dart';
import '../../domain/entities/store_fulfillment_type.dart';
import '../../domain/entities/store_order.dart';
import '../../domain/repos/i_customer_store_repo.dart';
import '../apis/customer_store_api.dart';
import '../models/shop_storefront_model.dart';
import '../models/store_cart_model.dart';
import '../models/store_order_model.dart';

class CustomerStoreRepo implements ICustomerStoreRepo {
  final CustomerStoreApi _api;

  CustomerStoreRepo(this._api);

  @override
  Future<Either<Failure, ShopStorefront>> getStorefront(int shopId) async {
    final result = await _api.getStorefront(shopId);
    return result.map(
      (response) =>
          ShopStorefrontModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, StoreCart>> getCart() async {
    final result = await _api.getCart();
    return result.map(_mapCart);
  }

  @override
  Future<Either<Failure, StoreCart>> putCart(
    Map<int, int> quantitiesByProductId,
  ) async {
    final result = await _api.putCart({
      'items': quantitiesByProductId.entries
          .map((e) => {'productId': e.key, 'quantity': e.value})
          .toList(),
    });
    return result.map(_mapCart);
  }

  @override
  Future<Either<Failure, StoreOrder>> checkout({
    required StoreFulfillmentType? fulfillmentType,
    required String paymentMethod,
    String? deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
    String? note,
  }) async {
    final result = await _api.checkout({
      if (fulfillmentType != null) 'fulfillmentType': fulfillmentType.toApi(),
      'paymentMethod': paymentMethod,
      if (deliveryAddress != null) 'deliveryAddress': deliveryAddress,
      if (deliveryLat != null) 'deliveryLat': deliveryLat,
      if (deliveryLng != null) 'deliveryLng': deliveryLng,
      if (note != null) 'note': note,
    });
    return result.map(_mapOrder);
  }

  @override
  Future<Either<Failure, List<StoreOrder>>> getOrders() async {
    final result = await _api.getOrders();
    return result.map(
      (response) => (response['data'] as List<dynamic>? ?? [])
          .map((e) => StoreOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Future<Either<Failure, StoreOrder>> getOrder(int id) async {
    final result = await _api.getOrder(id);
    return result.map(_mapOrder);
  }

  @override
  Future<Either<Failure, StoreOrder>> cancelOrder(int id) async {
    final result = await _api.cancelOrder(id);
    return result.map(_mapOrder);
  }

  StoreCart _mapCart(dynamic response) {
    return StoreCartModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  StoreOrder _mapOrder(dynamic response) {
    return StoreOrderModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
