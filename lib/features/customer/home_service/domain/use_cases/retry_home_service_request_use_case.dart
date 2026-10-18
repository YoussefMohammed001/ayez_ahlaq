import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_request.dart';
import '../repos/i_customer_home_service_repo.dart';

class RetryHomeServiceRequestUseCase {
  final ICustomerHomeServiceRepo _repo;

  RetryHomeServiceRequestUseCase(this._repo);

  Future<Either<Failure, HomeServiceRequest>> call({
    required int id,
    int? shopId,
    bool anyNearby = false,
    required String address,
    required double lat,
    required double lng,
    String? note,
    required String date,
    required String time,
  }) => _repo.retryRequest(
    id: id,
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
