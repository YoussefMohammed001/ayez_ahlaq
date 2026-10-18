import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/rating_target.dart';
import '../../../../barber/hours/domain/entities/working_day.dart';
import '../entities/home_service_request.dart';
import '../entities/home_service_shop.dart';

abstract class ICustomerHomeServiceRepo {
  Future<Either<Failure, List<HomeServiceShop>>> getShops({
    required String date,
    required String time,
    double? lat,
    double? lng,
  });

  Future<Either<Failure, List<WorkingDay>>> getHours(int shopId);

  Future<Either<Failure, HomeServiceRequest>> createRequest({
    int? shopId,
    bool anyNearby,
    required String address,
    required double lat,
    required double lng,
    String? note,
    required String date,
    required String time,
  });

  Future<Either<Failure, HomeServiceRequest>> retryRequest({
    required int id,
    int? shopId,
    bool anyNearby,
    required String address,
    required double lat,
    required double lng,
    String? note,
    required String date,
    required String time,
  });

  Future<Either<Failure, List<HomeServiceRequest>>> getMyRequests();

  Future<Either<Failure, HomeServiceRequest>> getRequest(int id);

  Future<Either<Failure, HomeServiceRequest>> confirmPrice(int id);

  Future<Either<Failure, HomeServiceRequest>> cancel(int id);

  Future<Either<Failure, Unit>> rate({
    required int homeServiceRequestId,
    required RatingTarget target,
    required int stars,
    String? note,
  });
}
