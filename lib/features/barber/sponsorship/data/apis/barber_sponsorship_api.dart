import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberSponsorshipApi {
  final NetworkService _networkService;

  BarberSponsorshipApi(this._networkService);

  Future<Either<Failure, dynamic>> getSponsorship() {
    return _networkService.getData(endPoint: EndPoints.barberSponsorship);
  }

  Future<Either<Failure, dynamic>> buySponsorship() {
    return _networkService.postData(
      endPoint: EndPoints.barberSponsorship,
      data: const {},
    );
  }
}
