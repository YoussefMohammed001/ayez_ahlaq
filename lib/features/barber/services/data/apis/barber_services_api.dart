import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberServicesApi {
  final NetworkService _networkService;

  BarberServicesApi(this._networkService);

  Future<Either<Failure, dynamic>> getCatalog() {
    return _networkService.getData(endPoint: EndPoints.barberServiceCatalog);
  }

  Future<Either<Failure, dynamic>> getServices() {
    return _networkService.getData(endPoint: EndPoints.barberService);
  }

  Future<Either<Failure, dynamic>> createService(Map<String, dynamic> body) {
    return _networkService.postData(endPoint: EndPoints.barberService, data: body);
  }

  Future<Either<Failure, dynamic>> updateService(
    int id,
    Map<String, dynamic> body,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.barberServiceById(id),
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> deleteService(int id) {
    return _networkService.deleteData(endPoint: EndPoints.barberServiceById(id));
  }
}
