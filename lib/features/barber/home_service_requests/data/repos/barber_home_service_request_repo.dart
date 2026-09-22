import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/home_service_request.dart';
import '../../domain/entities/home_service_request_adjustment.dart';
import '../../domain/entities/home_service_request_status.dart';
import '../../domain/repos/i_barber_home_service_request_repo.dart';
import '../apis/barber_home_service_request_api.dart';
import '../models/home_service_request_adjustment_model.dart';
import '../models/home_service_request_model.dart';

class BarberHomeServiceRequestRepo implements IBarberHomeServiceRequestRepo {
  final BarberHomeServiceRequestApi _api;

  BarberHomeServiceRequestRepo(this._api);

  @override
  Future<Either<Failure, List<HomeServiceRequest>>> getRequests({
    HomeServiceRequestStatus? status,
  }) async {
    final result = await _api.getRequests(status: status?.toApi());
    return result.map(_mapMany);
  }

  @override
  Future<Either<Failure, HomeServiceRequest>> getRequest(int id) async {
    final result = await _api.getRequest(id);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, HomeServiceRequest>> updatePrice(
    int id,
    List<HomeServiceRequestAdjustment> adjustments,
  ) async {
    final result = await _api.updatePrice(
      id,
      adjustments.map(HomeServiceRequestAdjustmentModel.toJson).toList(),
    );
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, HomeServiceRequest>> accept(int id) async {
    final result = await _api.accept(id);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, HomeServiceRequest>> reject(
    int id,
    String reason,
  ) async {
    final result = await _api.reject(id, reason);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, HomeServiceRequest>> updateStatus(
    int id,
    HomeServiceRequestStatus status,
  ) async {
    final result = await _api.updateStatus(id, status.toApi());
    return result.flatMap(_mapOne);
  }

  List<HomeServiceRequest> _mapMany(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => HomeServiceRequestModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Either<Failure, HomeServiceRequest> _mapOne(dynamic response) {
    return requireDataMap(response).map(HomeServiceRequestModel.fromJson);
  }
}
