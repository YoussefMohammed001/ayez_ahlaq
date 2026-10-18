import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberStoreFeedApi {
  final NetworkService _networkService;

  BarberStoreFeedApi(this._networkService);

  Future<Either<Failure, dynamic>> getProducts({
    String? search,
    int? categoryId,
    int? merchantId,
    required String sort,
    String? cursor,
    required int limit,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.barberStoreProduct,
      queryParameters: {
        if (search != null && search.isNotEmpty) 'search': search,
        if (categoryId != null) 'category': categoryId,
        if (merchantId != null) 'merchantId': merchantId,
        'sort': sort,
        if (cursor != null) 'cursor': cursor,
        'limit': limit,
      },
    );
  }

  Future<Either<Failure, dynamic>> getCategories() {
    return _networkService.getData(endPoint: EndPoints.barberStoreCategory);
  }
}
