import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/barber_discount_request.dart';
import '../entities/barber_discount.dart';
import '../repos/i_barber_discounts_repo.dart';

class CreateBarberDiscountUseCase {
  final IBarberDiscountsRepo _repo;

  CreateBarberDiscountUseCase(this._repo);

  Future<Either<Failure, BarberDiscount>> call(BarberDiscountRequest request) =>
      _repo.createDiscount(request);
}
