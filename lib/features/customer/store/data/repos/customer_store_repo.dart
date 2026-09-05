import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/shop_storefront.dart';
import '../../domain/entities/store_fulfillment_type.dart';
import '../../domain/entities/store_order.dart';
import '../../domain/entities/store_quote.dart';
import '../../domain/repos/i_customer_store_repo.dart';
import '../apis/customer_store_api.dart';
import '../models/shop_storefront_model.dart';
import '../models/store_order_model.dart';
import '../models/store_quote_model.dart';

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
  Future<Either<Failure, StoreQuote>> quoteCart({
    required int shopId,
    required StoreFulfillmentType fulfillmentType,
    required Map<int, int> items,
  }) async {
    final result = await _api.quoteCart({
      'shopId': shopId,
      'fulfillmentType': fulfillmentType.toApi(),
      'items': _itemsToJson(items),
    });

    return result.map(
      (response) =>
          StoreQuoteModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, StoreOrder>> placeOrder({
    required int shopId,
    required StoreFulfillmentType fulfillmentType,
    required String paymentMethod,
    String? note,
    required Map<int, int> items,
  }) async {
    final result = await _api.placeOrder({
      'shopId': shopId,
      'fulfillmentType': fulfillmentType.toApi(),
      'paymentMethod': paymentMethod,
      'note': note,
      'items': _itemsToJson(items),
    });

    return result.map(
      (response) =>
          StoreOrderModel.fromJson(response['data'] as Map<String, dynamic>),
    );
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

    return result.map(
      (response) =>
          StoreOrderModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, StoreOrder>> cancelOrder(int id) async {
    final result = await _api.cancelOrder(id);

    return result.map(
      (response) =>
          StoreOrderModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }

  List<Map<String, dynamic>> _itemsToJson(Map<int, int> items) {
    return items.entries
        .map((e) => {'productId': e.key, 'quantity': e.value})
        .toList();
  }
}
