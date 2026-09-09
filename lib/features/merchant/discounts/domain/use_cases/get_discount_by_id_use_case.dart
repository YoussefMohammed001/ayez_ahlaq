import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/discount.dart';
import '../repos/i_merchant_discounts_repo.dart';

class GetDiscountByIdUseCase {
  final IMerchantDiscountsRepo _repo;

  GetDiscountByIdUseCase(this._repo);

  Future<Either<Failure, Discount>> call(int id) => _repo.getDiscountById(id);
}
