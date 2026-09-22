import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_discounts_repo.dart';

class CloseBarberDiscountUseCase {
  final IBarberDiscountsRepo _repo;

  CloseBarberDiscountUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.closeDiscount(id);
}
