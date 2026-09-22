import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_discount.dart';
import '../repos/i_barber_discounts_repo.dart';

class GetBarberDiscountsUseCase {
  final IBarberDiscountsRepo _repo;

  GetBarberDiscountsUseCase(this._repo);

  Future<Either<Failure, List<BarberDiscount>>> call() => _repo.getDiscounts();
}
