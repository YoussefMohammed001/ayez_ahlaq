import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberInviteApi {
  final NetworkService _networkService;

  BarberInviteApi(this._networkService);

  Future<Either<Failure, dynamic>> getInvite() {
    return _networkService.getData(endPoint: EndPoints.barberInvite);
  }

  Future<Either<Failure, dynamic>> regenerateInvite() {
    return _networkService.putData(
      endPoint: EndPoints.barberInviteRegenerate,
      data: const {},
    );
  }
}
