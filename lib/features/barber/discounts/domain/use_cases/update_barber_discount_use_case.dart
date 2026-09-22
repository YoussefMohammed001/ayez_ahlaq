import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/barber_discount_request.dart';
import '../entities/barber_discount.dart';
import '../repos/i_barber_discounts_repo.dart';

class UpdateBarberDiscountUseCase {
  final IBarberDiscountsRepo _repo;

  UpdateBarberDiscountUseCase(this._repo);

  Future<Either<Failure, BarberDiscount>> call(
    int id,
    BarberDiscountRequest request,
  ) => _repo.updateDiscount(id, request);
}
