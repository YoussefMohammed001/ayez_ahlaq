import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/discount_request.dart';
import '../entities/discount.dart';
import '../repos/i_merchant_discounts_repo.dart';

class CreateDiscountUseCase {
  final IMerchantDiscountsRepo _repo;

  CreateDiscountUseCase(this._repo);

  Future<Either<Failure, Discount>> call(DiscountRequest request) =>
      _repo.createDiscount(request);
}
