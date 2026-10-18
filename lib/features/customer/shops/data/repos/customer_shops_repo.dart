import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/shop.dart';
import '../../domain/entities/shop_detail.dart';
import '../../domain/repos/i_customer_shops_repo.dart';
import '../apis/customer_shops_api.dart';
import '../models/shop_detail_model.dart';
import '../models/shop_model.dart';

class CustomerShopsRepo implements ICustomerShopsRepo {
  final CustomerShopsApi _api;

  CustomerShopsRepo(this._api);

  @override
  Future<Either<Failure, List<Shop>>> getShops({
    double? lat,
    double? lng,
  }) async {
    final result = await _api.getShops(lat: lat, lng: lng);

    return result.map(
      (response) => (response['data'] as List<dynamic>? ?? [])
          .map((e) => ShopModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Future<Either<Failure, ShopDetail>> getShopDetail(int shopId) async {
    final result = await _api.getShopDetail(shopId);

    return result.map(
      (response) =>
          ShopDetailModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }
}
