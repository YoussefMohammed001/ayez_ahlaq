import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/discount_request.dart';
import '../entities/discount.dart';
import '../entities/discount_shop.dart';

abstract class IMerchantDiscountsRepo {
  Future<Either<Failure, List<Discount>>> getDiscounts();

  Future<Either<Failure, List<DiscountShop>>> getShops();

  Future<Either<Failure, Discount>> createDiscount(DiscountRequest request);

  Future<Either<Failure, Discount>> updateDiscount(
    int id,
    DiscountRequest request,
  );

  Future<Either<Failure, Unit>> closeDiscount(int id);
}
