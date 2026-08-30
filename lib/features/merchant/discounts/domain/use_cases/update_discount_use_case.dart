import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/discount_request.dart';
import '../entities/discount.dart';
import '../repos/i_merchant_discounts_repo.dart';

class UpdateDiscountUseCase {
  final IMerchantDiscountsRepo _repo;

  UpdateDiscountUseCase(this._repo);

  Future<Either<Failure, Discount>> call(int id, DiscountRequest request) =>
      _repo.updateDiscount(id, request);
}
