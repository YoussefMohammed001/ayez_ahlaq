import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_discounts_repo.dart';

class CloseDiscountUseCase {
  final IMerchantDiscountsRepo _repo;

  CloseDiscountUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.closeDiscount(id);
}
