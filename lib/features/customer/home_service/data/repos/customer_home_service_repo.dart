import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/rating_target.dart';
import '../../../../barber/hours/domain/entities/working_day.dart';
import '../../domain/entities/home_service_request.dart';
import '../../domain/entities/home_service_shop.dart';
import '../../domain/repos/i_customer_home_service_repo.dart';
import '../apis/customer_home_service_api.dart';
import 'customer_home_service_mappers.dart';

class CustomerHomeServiceRepo implements ICustomerHomeServiceRepo {
  final CustomerHomeServiceApi _api;

  CustomerHomeServiceRepo(this._api);

  @override
  Future<Either<Failure, List<HomeServiceShop>>> getShops({
    required String date,
    required String time,
    double? lat,
    double? lng,
  }) async {
    final result = await _api.getShops(
      date: date,
      time: time,
      lat: lat,
      lng: lng,
    );
    return result.map(CustomerHomeServiceMappers.shops);
  }

  @override
  Future<Either<Failure, List<WorkingDay>>> getHours(int shopId) async {
    final result = await _api.getHours(shopId);
    return result.map(CustomerHomeServiceMappers.hours);
  }

  @override
  Future<Either<Failure, HomeServiceRequest>> createRequest({
    int? shopId,
    bool anyNearby = false,
    required String address,
    required double lat,
    required double lng,
    String? note,
    required String date,
    required String time,
  }) async {
    final result = await _api.createRequest(
      shopId: shopId,
      anyNearby: anyNearby,
      address: address,
      lat: lat,
      lng: lng,
      note: note,
      date: date,
      time: time,
    );
    return result.flatMap(CustomerHomeServiceMappers.request);
  }

  @override
  Future<Either<Failure, HomeServiceRequest>> retryRequest({
    required int id,
    int? shopId,
    bool anyNearby = false,
    required String address,
    required double lat,
    required double lng,
    String? note,
    required String date,
    required String time,
  }) async {
    final result = await _api.retryRequest(
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
    return result.flatMap(CustomerHomeServiceMappers.request);
  }

  @override
  Future<Either<Failure, List<HomeServiceRequest>>> getMyRequests() async {
    final result = await _api.getMyRequests();
    return result.map(CustomerHomeServiceMappers.requests);
  }

  @override
  Future<Either<Failure, HomeServiceRequest>> getRequest(int id) async {
    final result = await _api.getRequest(id);
    return result.flatMap(CustomerHomeServiceMappers.request);
  }

  @override
  Future<Either<Failure, HomeServiceRequest>> confirmPrice(int id) async {
    final result = await _api.confirmPrice(id);
    return result.flatMap(CustomerHomeServiceMappers.request);
  }

  @override
  Future<Either<Failure, HomeServiceRequest>> cancel(int id) async {
    final result = await _api.cancel(id);
    return result.flatMap(CustomerHomeServiceMappers.request);
  }

  @override
  Future<Either<Failure, Unit>> rate({
    required int homeServiceRequestId,
    required RatingTarget target,
    required int stars,
    String? note,
  }) async {
    final result = await _api.rate({
      'homeServiceRequestId': homeServiceRequestId,
      'target': target.toApi,
      'stars': stars,
      'note': note,
    });
    return result.map((_) => unit);
  }
}
