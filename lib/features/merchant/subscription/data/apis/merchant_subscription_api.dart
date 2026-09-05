import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class MerchantSubscriptionApi {
  final NetworkService _networkService;
  MerchantSubscriptionApi(this._networkService);

  Future<Either<Failure, dynamic>> getSubscription() {
    return _networkService.getData(endPoint: EndPoints.merchantSubscription);
  }

  Future<Either<Failure, dynamic>> getPlans() {
    return _networkService.getData(endPoint: EndPoints.merchantSubscriptionPlan);
  }

  Future<Either<Failure, dynamic>> subscribe(int planId) {
    return _networkService.postData(
      endPoint: EndPoints.merchantSubscriptionSubscribe,
      data: {'planId': planId},
    );
  }

  Future<Either<Failure, dynamic>> getRequests() {
    return _networkService.getData(endPoint: EndPoints.merchantSubscriptionRequest);
  }
}
