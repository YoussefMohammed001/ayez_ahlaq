import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberSubscriptionApi {
  final NetworkService _networkService;
  BarberSubscriptionApi(this._networkService);

  Future<Either<Failure, dynamic>> getSubscription() {
    return _networkService.getData(endPoint: EndPoints.barberSubscription);
  }

  Future<Either<Failure, dynamic>> getPlans() {
    return _networkService.getData(endPoint: EndPoints.barberSubscriptionPlan);
  }

  Future<Either<Failure, dynamic>> subscribe(int planId) {
    return _networkService.postData(
      endPoint: EndPoints.barberSubscriptionSubscribe,
      data: {'planId': planId},
    );
  }

  Future<Either<Failure, dynamic>> getRequests() {
    return _networkService.getData(endPoint: EndPoints.barberSubscriptionRequest);
  }
}
