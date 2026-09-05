import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/shop.dart';
import '../repos/i_customer_shops_repo.dart';

class GetShopsUseCase {
  final ICustomerShopsRepo _repo;

  GetShopsUseCase(this._repo);

  Future<Either<Failure, List<Shop>>> call({double? lat, double? lng}) =>
      _repo.getShops(lat: lat, lng: lng);
}
