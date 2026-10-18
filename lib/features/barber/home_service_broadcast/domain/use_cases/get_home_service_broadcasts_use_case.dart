import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_broadcast.dart';
import '../repos/i_barber_home_service_broadcast_repo.dart';

class GetHomeServiceBroadcastsUseCase {
  final IBarberHomeServiceBroadcastRepo _repo;

  GetHomeServiceBroadcastsUseCase(this._repo);

  Future<Either<Failure, List<HomeServiceBroadcast>>> call() =>
      _repo.getBroadcasts();
}
