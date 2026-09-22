import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/drink.dart';
import '../../domain/repos/i_barber_drinks_repo.dart';
import '../apis/barber_drinks_api.dart';
import '../models/drink_model.dart';

class BarberDrinksRepo implements IBarberDrinksRepo {
  final BarberDrinksApi _api;

  BarberDrinksRepo(this._api);

  @override
  Future<Either<Failure, List<Drink>>> getDrinks() async {
    final result = await _api.getDrinks();
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, Drink>> createDrink(String name, int price) async {
    final result = await _api.createDrink(name, price);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, Drink>> updateDrink(
    int id,
    String name,
    int price,
    bool active,
  ) async {
    final result = await _api.updateDrink(id, name, price, active);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, Unit>> deleteDrink(int id) async {
    final result = await _api.deleteDrink(id);
    return result.map((_) => unit);
  }

  List<Drink> _mapList(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map<Drink>((e) => DrinkModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Either<Failure, Drink> _mapOne(dynamic response) {
    return requireDataMap(response).map(DrinkModel.fromJson);
  }
}
