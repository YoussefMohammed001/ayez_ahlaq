import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_drinks_repo.dart';

class DeleteDrinkUseCase {
  final IBarberDrinksRepo _repo;

  DeleteDrinkUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.deleteDrink(id);
}
