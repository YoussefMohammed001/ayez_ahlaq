import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_request.dart';
import '../repos/i_customer_home_service_repo.dart';

class CreateHomeServiceRequestUseCase {
  final ICustomerHomeServiceRepo _repo;

  CreateHomeServiceRequestUseCase(this._repo);

  Future<Either<Failure, HomeServiceRequest>> call({
    int? shopId,
    bool anyNearby = false,
    required String address,
    required double lat,
    required double lng,
    String? note,
    required String date,
    required String time,
  }) => _repo.createRequest(
    shopId: shopId,
    anyNearby: anyNearby,
    address: address,
    lat: lat,
    lng: lng,
    note: note,
    date: date,
    time: time,
  );
}
