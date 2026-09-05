import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/fulfillment_type.dart';
import '../../domain/entities/store_merchant.dart';
import '../../domain/entities/store_order.dart';
import '../../domain/entities/store_product.dart';
import '../../domain/repos/i_barber_store_repo.dart';
import '../apis/barber_store_api.dart';
import '../models/cart_model.dart';
import '../models/store_merchant_model.dart';
import '../models/store_order_model.dart';
import '../models/store_product_model.dart';

class BarberStoreRepo implements IBarberStoreRepo {
  final BarberStoreApi _api;

  BarberStoreRepo(this._api);

  @override
  Future<Either<Failure, List<StoreMerchant>>> getMerchants() async {
    final result = await _api.getMerchants();
    return result.map(_mapMerchants);
  }

  @override
  Future<Either<Failure, List<StoreProduct>>> getMerchantProducts(
    int merchantId,
  ) async {
    final result = await _api.getMerchantProducts(merchantId);
    return result.map(_mapProducts);
  }

  @override
  Future<Either<Failure, Cart>> getCart() async {
    final result = await _api.getCart();
    return result.map(_mapCart);
  }

  @override
  Future<Either<Failure, Cart>> putCart(
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
    required FulfillmentType? fulfillmentType,
    String? deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
    String? note,
  }) async {
    final result = await _api.checkout({
      if (fulfillmentType != null) 'fulfillmentType': fulfillmentType.toApi(),
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
    return result.map(_mapOrders);
  }

  @override
  Future<Either<Failure, StoreOrder>> getOrderById(int id) async {
    final result = await _api.getOrderById(id);
    return result.map(_mapOrder);
  }

  @override
  Future<Either<Failure, Unit>> cancelOrder(int id) async {
    final result = await _api.cancelOrder(id);
    return result.map((_) => unit);
  }

  List<StoreMerchant> _mapMerchants(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => StoreMerchantModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  List<StoreProduct> _mapProducts(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => StoreProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  List<StoreOrder> _mapOrders(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return List<StoreOrder>.of(
      data.map((json) => StoreOrderModel.fromJson(json as Map<String, dynamic>)),
    );
  }

  StoreOrder _mapOrder(dynamic response) {
    return StoreOrderModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  Cart _mapCart(dynamic response) {
    return CartModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
