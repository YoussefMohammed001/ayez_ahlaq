import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_broadcast.dart';
import '../repos/i_barber_home_service_broadcast_repo.dart';

class GetHomeServiceBroadcastForRequestUseCase {
  final IBarberHomeServiceBroadcastRepo _repo;

  GetHomeServiceBroadcastForRequestUseCase(this._repo);

  Future<Either<Failure, HomeServiceBroadcast>> call(int requestId) =>
      _repo.getBroadcastForRequest(requestId);
}
