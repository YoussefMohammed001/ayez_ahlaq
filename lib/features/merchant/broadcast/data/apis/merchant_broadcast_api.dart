import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class MerchantBroadcastApi {
  final NetworkService _networkService;

  MerchantBroadcastApi(this._networkService);

  Future<Either<Failure, dynamic>> send({
    required String scope,
    required String title,
    required String body,
  }) {
    return _networkService.postData(
      endPoint: EndPoints.merchantBroadcast,
      data: {'scope': scope, 'title': title, 'body': body},
    );
  }

  Future<Either<Failure, dynamic>> list({
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.merchantBroadcast,
      queryParameters: {'page': page, 'size': size},
    );
  }
}
