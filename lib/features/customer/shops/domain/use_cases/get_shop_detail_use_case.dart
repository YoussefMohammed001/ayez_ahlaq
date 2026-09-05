import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/shop_detail.dart';
import '../repos/i_customer_shops_repo.dart';

class GetShopDetailUseCase {
  final ICustomerShopsRepo _repo;

  GetShopDetailUseCase(this._repo);

  Future<Either<Failure, ShopDetail>> call(int shopId) =>
      _repo.getShopDetail(shopId);
}
