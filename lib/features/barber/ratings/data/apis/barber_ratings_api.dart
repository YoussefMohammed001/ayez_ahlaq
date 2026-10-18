import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberRatingsApi {
  final NetworkService _networkService;

  BarberRatingsApi(this._networkService);

  Future<Either<Failure, dynamic>> getPendingMerchantRating() {
    return _networkService.getData(endPoint: EndPoints.barberRatingPending);
  }

  Future<Either<Failure, dynamic>> submitMerchantRating(
    Map<String, dynamic> body,
  ) {
    return _networkService.postData(
      endPoint: EndPoints.barberRatingMerchant,
      data: body,
    );
  }
}
