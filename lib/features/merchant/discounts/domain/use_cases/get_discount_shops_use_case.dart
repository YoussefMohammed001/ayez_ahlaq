import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/discount_shop.dart';
import '../repos/i_merchant_discounts_repo.dart';

class GetDiscountShopsUseCase {
  final IMerchantDiscountsRepo _repo;

  GetDiscountShopsUseCase(this._repo);

  Future<Either<Failure, List<DiscountShop>>> call() => _repo.getShops();
}
