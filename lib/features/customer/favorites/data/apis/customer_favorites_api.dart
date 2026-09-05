import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class CustomerFavoritesApi {
  final NetworkService _networkService;

  CustomerFavoritesApi(this._networkService);

  Future<Either<Failure, dynamic>> getFavorites() {
    return _networkService.getData(endPoint: EndPoints.customerFavorite);
  }

  Future<Either<Failure, dynamic>> addFavorite(int barberId) {
    return _networkService.postData(
      endPoint: EndPoints.customerFavoriteById(barberId),
    );
  }

  Future<Either<Failure, dynamic>> removeFavorite(int barberId) {
    return _networkService.deleteData(
      endPoint: EndPoints.customerFavoriteById(barberId),
    );
  }

  Future<Either<Failure, dynamic>> addFavoriteViaInvite(String inviteCode) {
    return _networkService.postData(
      endPoint: EndPoints.customerFavoriteInvite(inviteCode),
    );
  }

  Future<Either<Failure, dynamic>> getInvitePreview(String code) {
    return _networkService.getData(endPoint: EndPoints.invitePreview(code));
  }
}
