import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class CustomerRatingsApi {
  final NetworkService _networkService;

  CustomerRatingsApi(this._networkService);

  Future<Either<Failure, dynamic>> getRatings() {
    return _networkService.getData(endPoint: EndPoints.customerRating);
  }
}
