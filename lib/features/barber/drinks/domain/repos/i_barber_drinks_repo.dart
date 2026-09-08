import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/drink.dart';

abstract class IBarberDrinksRepo {
  Future<Either<Failure, List<Drink>>> getDrinks();

  Future<Either<Failure, Drink>> createDrink(String name, int price);

  Future<Either<Failure, Drink>> updateDrink(
    int id,
    String name,
    int price,
    bool active,
  );

  Future<Either<Failure, Unit>> deleteDrink(int id);
}
