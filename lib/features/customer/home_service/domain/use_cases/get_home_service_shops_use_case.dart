import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_shop.dart';
import '../repos/i_customer_home_service_repo.dart';

class GetHomeServiceShopsUseCase {
  final ICustomerHomeServiceRepo _repo;

  GetHomeServiceShopsUseCase(this._repo);

  Future<Either<Failure, List<HomeServiceShop>>> call({
    double? lat,
    double? lng,
  }) => _repo.getShops(lat: lat, lng: lng);
}
