import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/home_service_broadcast.dart';
import '../../domain/repos/i_barber_home_service_broadcast_repo.dart';
import '../apis/barber_home_service_broadcast_api.dart';
import '../models/home_service_broadcast_model.dart';

class BarberHomeServiceBroadcastRepo implements IBarberHomeServiceBroadcastRepo {
  final BarberHomeServiceBroadcastApi _api;

  BarberHomeServiceBroadcastRepo(this._api);

  @override
  Future<Either<Failure, List<HomeServiceBroadcast>>> getBroadcasts() async {
    final result = await _api.getBroadcasts();
    return result.map(_mapMany);
  }

  @override
  Future<Either<Failure, HomeServiceBroadcast>> getBroadcastForRequest(
    int requestId,
  ) async {
    final result = await _api.getBroadcastForRequest(requestId);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, Unit>> accept(int candidateId) async {
    final result = await _api.accept(candidateId);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> reject(int candidateId) async {
    final result = await _api.reject(candidateId);
    return result.map((_) => unit);
  }

  List<HomeServiceBroadcast> _mapMany(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map(
          (json) =>
              HomeServiceBroadcastModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  Either<Failure, HomeServiceBroadcast> _mapOne(dynamic response) {
    return requireDataMap(response).map(HomeServiceBroadcastModel.fromJson);
  }
}
