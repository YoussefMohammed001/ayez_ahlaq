import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_discount.dart';
import '../repos/i_barber_discounts_repo.dart';

class GetBarberDiscountByIdUseCase {
  final IBarberDiscountsRepo _repo;

  GetBarberDiscountByIdUseCase(this._repo);

  Future<Either<Failure, BarberDiscount>> call(int id) =>
      _repo.getDiscountById(id);
}
