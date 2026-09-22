import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberHomeServiceApi {
  final NetworkService _networkService;

  BarberHomeServiceApi(this._networkService);

  Future<Either<Failure, dynamic>> getSettings() {
    return _networkService.getData(endPoint: EndPoints.barberHomeService);
  }

  Future<Either<Failure, dynamic>> updateSettings({
    required bool enabled,
    num? price,
    String? note,
  }) {
    return _networkService.putData(
      endPoint: EndPoints.barberHomeService,
      data: {'enabled': enabled, 'price': price, 'note': note},
    );
  }
}
