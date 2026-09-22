import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_request.dart';
import '../repos/i_customer_home_service_repo.dart';

class CreateHomeServiceRequestUseCase {
  final ICustomerHomeServiceRepo _repo;

  CreateHomeServiceRequestUseCase(this._repo);

  Future<Either<Failure, HomeServiceRequest>> call({
    required int shopId,
    required String address,
    required double lat,
    required double lng,
    String? note,
  }) => _repo.createRequest(
    shopId: shopId,
    address: address,
    lat: lat,
    lng: lng,
    note: note,
  );
}
