import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberHomeServiceBroadcastApi {
  final NetworkService _networkService;

  BarberHomeServiceBroadcastApi(this._networkService);

  Future<Either<Failure, dynamic>> getBroadcasts() {
    return _networkService.getData(
      endPoint: EndPoints.barberHomeServiceBroadcast,
    );
  }

  Future<Either<Failure, dynamic>> getBroadcastForRequest(int requestId) {
    return _networkService.getData(
      endPoint: EndPoints.barberHomeServiceBroadcastRequest(requestId),
    );
  }

  Future<Either<Failure, dynamic>> accept(int broadcastId) {
    return _networkService.putData(
      endPoint: EndPoints.barberHomeServiceBroadcastAccept(broadcastId),
    );
  }

  Future<Either<Failure, dynamic>> reject(int broadcastId) {
    return _networkService.putData(
      endPoint: EndPoints.barberHomeServiceBroadcastReject(broadcastId),
    );
  }
}
