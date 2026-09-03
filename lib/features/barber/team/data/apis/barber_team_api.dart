import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberTeamApi {
  final NetworkService _networkService;

  BarberTeamApi(this._networkService);

  Future<Either<Failure, dynamic>> getTeam() {
    return _networkService.getData(endPoint: EndPoints.barberTeam);
  }

  Future<Either<Failure, dynamic>> addMember(Map<String, dynamic> body) {
    return _networkService.postData(endPoint: EndPoints.barberTeam, data: body);
  }

  Future<Either<Failure, dynamic>> getMember(int id) {
    return _networkService.getData(endPoint: EndPoints.barberTeamById(id));
  }

  Future<Either<Failure, dynamic>> updateMember(
    int id,
    Map<String, dynamic> body,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.barberTeamById(id),
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> setAvailability(int id, bool available) {
    return _networkService.putData(
      endPoint: EndPoints.barberTeamAvailability(id),
      data: {'available': available},
    );
  }

  Future<Either<Failure, dynamic>> resetPassword(int id, String tempPassword) {
    return _networkService.putData(
      endPoint: EndPoints.barberTeamPassword(id),
      data: {'tempPassword': tempPassword},
    );
  }

  Future<Either<Failure, dynamic>> blockMember(int id) {
    return _networkService.deleteData(endPoint: EndPoints.barberTeamById(id));
  }

  Future<Either<Failure, dynamic>> activateMember(int id) {
    return _networkService.putData(
      endPoint: EndPoints.barberTeamActivate(id),
      data: const {},
    );
  }
}
