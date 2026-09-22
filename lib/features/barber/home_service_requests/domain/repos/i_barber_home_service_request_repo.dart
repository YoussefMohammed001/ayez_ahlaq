import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_request.dart';
import '../entities/home_service_request_adjustment.dart';
import '../entities/home_service_request_status.dart';

abstract class IBarberHomeServiceRequestRepo {
  Future<Either<Failure, List<HomeServiceRequest>>> getRequests({
    HomeServiceRequestStatus? status,
  });

  Future<Either<Failure, HomeServiceRequest>> getRequest(int id);

  Future<Either<Failure, HomeServiceRequest>> updatePrice(
    int id,
    List<HomeServiceRequestAdjustment> adjustments,
  );

  Future<Either<Failure, HomeServiceRequest>> accept(int id);

  Future<Either<Failure, HomeServiceRequest>> reject(int id, String reason);

  Future<Either<Failure, HomeServiceRequest>> updateStatus(
    int id,
    HomeServiceRequestStatus status,
  );
}
