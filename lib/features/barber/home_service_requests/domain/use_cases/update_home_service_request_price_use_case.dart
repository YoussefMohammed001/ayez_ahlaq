import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_request.dart';
import '../entities/home_service_request_adjustment.dart';
import '../repos/i_barber_home_service_request_repo.dart';

class UpdateHomeServiceRequestPriceUseCase {
  final IBarberHomeServiceRequestRepo _repo;

  UpdateHomeServiceRequestPriceUseCase(this._repo);

  Future<Either<Failure, HomeServiceRequest>> call(
    int id,
    List<HomeServiceRequestAdjustment> adjustments,
  ) => _repo.updatePrice(id, adjustments);
}
