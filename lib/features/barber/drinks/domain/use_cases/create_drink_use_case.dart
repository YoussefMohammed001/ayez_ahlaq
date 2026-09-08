import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/drink.dart';
import '../repos/i_barber_drinks_repo.dart';

class CreateDrinkUseCase {
  final IBarberDrinksRepo _repo;

  CreateDrinkUseCase(this._repo);

  Future<Either<Failure, Drink>> call({
    required String name,
    required int price,
  }) => _repo.createDrink(name, price);
}
