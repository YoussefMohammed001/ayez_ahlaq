import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/drink.dart';
import '../repos/i_barber_drinks_repo.dart';

class GetDrinksUseCase {
  final IBarberDrinksRepo _repo;

  GetDrinksUseCase(this._repo);

  Future<Either<Failure, List<Drink>>> call() => _repo.getDrinks();
}
