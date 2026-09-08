import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberDrinksApi {
  final NetworkService _networkService;

  BarberDrinksApi(this._networkService);

  Future<Either<Failure, dynamic>> getDrinks() {
    return _networkService.getData(endPoint: EndPoints.barberDrink);
  }

  Future<Either<Failure, dynamic>> createDrink(String name, int price) {
    return _networkService.postData(
      endPoint: EndPoints.barberDrink,
      data: {'name': name, 'price': price},
    );
  }

  Future<Either<Failure, dynamic>> updateDrink(
    int id,
    String name,
    int price,
    bool active,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.barberDrinkById(id),
      data: {'name': name, 'price': price, 'active': active},
    );
  }

  Future<Either<Failure, dynamic>> deleteDrink(int id) {
    return _networkService.deleteData(
      endPoint: EndPoints.barberDrinkById(id),
    );
  }
}
