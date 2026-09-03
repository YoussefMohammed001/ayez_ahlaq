import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberTeamServicesApi {
  final NetworkService _networkService;

  BarberTeamServicesApi(this._networkService);

  Future<Either<Failure, dynamic>> getCatalog(int memberId) {
    return _networkService.getData(
      endPoint: EndPoints.barberTeamServiceCatalog(memberId),
    );
  }

  Future<Either<Failure, dynamic>> getServices(int memberId) {
    return _networkService.getData(
      endPoint: EndPoints.barberTeamService(memberId),
    );
  }

  Future<Either<Failure, dynamic>> createService(
    int memberId,
    Map<String, dynamic> body,
  ) {
    return _networkService.postData(
      endPoint: EndPoints.barberTeamService(memberId),
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> updateService(
    int memberId,
    int serviceId,
    Map<String, dynamic> body,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.barberTeamServiceById(memberId, serviceId),
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> deleteService(int memberId, int serviceId) {
    return _networkService.deleteData(
      endPoint: EndPoints.barberTeamServiceById(memberId, serviceId),
    );
  }
}
