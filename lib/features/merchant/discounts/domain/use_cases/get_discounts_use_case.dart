import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/discount.dart';
import '../repos/i_merchant_discounts_repo.dart';

class GetDiscountsUseCase {
  final IMerchantDiscountsRepo _repo;

  GetDiscountsUseCase(this._repo);

  Future<Either<Failure, List<Discount>>> call() => _repo.getDiscounts();
}
