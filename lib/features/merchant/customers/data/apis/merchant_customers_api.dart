import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class MerchantCustomersApi {
  final NetworkService _networkService;

  MerchantCustomersApi(this._networkService);

  Future<Either<Failure, dynamic>> getCustomers({
    required int page,
    required int size,
    String? query,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.merchantCustomer,
      queryParameters: {
        'page': page,
        'size': size,
        if (query != null && query.isNotEmpty) 'q': query,
      },
    );
  }
}
