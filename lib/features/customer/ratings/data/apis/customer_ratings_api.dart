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

  Future<Either<Failure, dynamic>> getPendingVisitRating() {
    return _networkService.getData(endPoint: EndPoints.customerRatingPending);
  }

  Future<Either<Failure, dynamic>> submitOrderRating(
    Map<String, dynamic> body,
  ) {
    return _networkService.postData(
      endPoint: EndPoints.customerRatingOrder,
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> submitVisitRating(
    Map<String, dynamic> body,
  ) {
    return _networkService.postData(
      endPoint: EndPoints.customerRatingVisit,
      data: body,
    );
  }
}
