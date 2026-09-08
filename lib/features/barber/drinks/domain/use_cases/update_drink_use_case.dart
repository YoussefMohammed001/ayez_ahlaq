import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/drink.dart';
import '../repos/i_barber_drinks_repo.dart';

class UpdateDrinkUseCase {
  final IBarberDrinksRepo _repo;

  UpdateDrinkUseCase(this._repo);

  Future<Either<Failure, Drink>> call({
    required int id,
    required String name,
    required int price,
    required bool active,
  }) => _repo.updateDrink(id, name, price, active);
}
