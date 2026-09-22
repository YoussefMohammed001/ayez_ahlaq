import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../../../barber/hours/data/models/working_day_model.dart';
import '../../../../barber/hours/domain/entities/working_day.dart';
import '../../domain/entities/home_service_request.dart';
import '../../domain/entities/home_service_shop.dart';
import '../../domain/repos/i_customer_home_service_repo.dart';
import '../apis/customer_home_service_api.dart';
import '../models/home_service_request_model.dart';
import '../models/home_service_shop_model.dart';

class CustomerHomeServiceRepo implements ICustomerHomeServiceRepo {
  final CustomerHomeServiceApi _api;

  CustomerHomeServiceRepo(this._api);

  @override
  Future<Either<Failure, List<HomeServiceShop>>> getShops({
    double? lat,
    double? lng,
  }) async {
    final result = await _api.getShops(lat: lat, lng: lng);
    return result.map(_mapShops);
  }

  @override
  Future<Either<Failure, List<WorkingDay>>> getHours(int shopId) async {
    final result = await _api.getHours(shopId);
    return result.map(_mapHours);
  }

  @override
  Future<Either<Failure, HomeServiceRequest>> createRequest({
    required int shopId,
    required String address,
    required double lat,
    required double lng,
    String? note,
  }) async {
    final result = await _api.createRequest(
      shopId: shopId,
      address: address,
      lat: lat,
      lng: lng,
      note: note,
    );
    return result.flatMap(_mapRequest);
  }

  @override
  Future<Either<Failure, List<HomeServiceRequest>>> getMyRequests() async {
    final result = await _api.getMyRequests();
    return result.map(_mapRequests);
  }

  @override
  Future<Either<Failure, HomeServiceRequest>> getRequest(int id) async {
    final result = await _api.getRequest(id);
    return result.flatMap(_mapRequest);
  }

  @override
  Future<Either<Failure, HomeServiceRequest>> confirmPrice(int id) async {
    final result = await _api.confirmPrice(id);
    return result.flatMap(_mapRequest);
  }

  @override
  Future<Either<Failure, HomeServiceRequest>> cancel(int id) async {
    final result = await _api.cancel(id);
    return result.flatMap(_mapRequest);
  }

  List<HomeServiceShop> _mapShops(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => HomeServiceShopModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  List<WorkingDay> _mapHours(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => WorkingDayModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  List<HomeServiceRequest> _mapRequests(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => HomeServiceRequestModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Either<Failure, HomeServiceRequest> _mapRequest(dynamic response) {
    return requireDataMap(response).map(HomeServiceRequestModel.fromJson);
  }
}
