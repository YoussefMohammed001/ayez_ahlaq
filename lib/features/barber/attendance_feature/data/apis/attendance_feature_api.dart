import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class AttendanceFeatureApi {
  final NetworkService _networkService;

  AttendanceFeatureApi(this._networkService);

  Future<Either<Failure, dynamic>> getStatus() {
    return _networkService.getData(endPoint: EndPoints.barberAttendanceFeature);
  }

  Future<Either<Failure, dynamic>> requestFeature() {
    return _networkService.postData(
      endPoint: EndPoints.barberAttendanceFeatureRequest,
    );
  }

  Future<Either<Failure, dynamic>> cancelRequest(int id) {
    return _networkService.putData(
      endPoint: EndPoints.barberAttendanceFeatureRequestCancel(id),
    );
  }

  Future<Either<Failure, dynamic>> getRequests({
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.barberAttendanceFeatureRequest,
      queryParameters: {'page': page, 'size': size},
    );
  }
}
