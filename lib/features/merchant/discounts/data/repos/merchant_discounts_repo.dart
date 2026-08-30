import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/discount.dart';
import '../../domain/entities/discount_shop.dart';
import '../../domain/repos/i_merchant_discounts_repo.dart';
import '../apis/merchant_discounts_api.dart';
import '../models/discount_model.dart';
import '../models/discount_shop_model.dart';
import '../requests/discount_request.dart';

class MerchantDiscountsRepo implements IMerchantDiscountsRepo {
  final MerchantDiscountsApi _api;

  MerchantDiscountsRepo(this._api);

  @override
  Future<Either<Failure, List<Discount>>> getDiscounts() async {
    final result = await _api.getDiscounts();
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, List<DiscountShop>>> getShops() async {
    final result = await _api.getShops();
    return result.map((response) {
      final data = response['data'] as List? ?? const [];
      return data
          .map<DiscountShop>(
            (e) => DiscountShopModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    });
  }

  @override
  Future<Either<Failure, Discount>> createDiscount(
    DiscountRequest request,
  ) async {
    final result = await _api.createDiscount(request);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Discount>> updateDiscount(
    int id,
    DiscountRequest request,
  ) async {
    final result = await _api.updateDiscount(id, request);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Unit>> closeDiscount(int id) async {
    final result = await _api.closeDiscount(id);
    return result.map((_) => unit);
  }

  List<Discount> _mapList(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map<Discount>((e) => DiscountModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Discount _mapOne(dynamic response) {
    return DiscountModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
