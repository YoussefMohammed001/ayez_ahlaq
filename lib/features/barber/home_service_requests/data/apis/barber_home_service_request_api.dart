import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberHomeServiceRequestApi {
  final NetworkService _networkService;

  BarberHomeServiceRequestApi(this._networkService);

  Future<Either<Failure, dynamic>> getRequests({String? status}) {
    return _networkService.getData(
      endPoint: EndPoints.barberHomeServiceRequest,
      queryParameters: status == null ? null : {'status': status},
    );
  }

  Future<Either<Failure, dynamic>> getRequest(int id) {
    return _networkService.getData(
      endPoint: EndPoints.barberHomeServiceRequestById(id),
    );
  }

  Future<Either<Failure, dynamic>> updatePrice(
    int id,
    List<Map<String, dynamic>> adjustments,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.barberHomeServiceRequestPrice(id),
      data: {'adjustments': adjustments},
    );
  }

  Future<Either<Failure, dynamic>> accept(int id) {
    return _networkService.putData(
      endPoint: EndPoints.barberHomeServiceRequestAccept(id),
    );
  }

  Future<Either<Failure, dynamic>> reject(int id, String reason) {
    return _networkService.putData(
      endPoint: EndPoints.barberHomeServiceRequestReject(id),
      data: {'reason': reason},
    );
  }

  Future<Either<Failure, dynamic>> updateStatus(int id, String status) {
    return _networkService.putData(
      endPoint: EndPoints.barberHomeServiceRequestStatus(id),
      data: {'status': status},
    );
  }
}
