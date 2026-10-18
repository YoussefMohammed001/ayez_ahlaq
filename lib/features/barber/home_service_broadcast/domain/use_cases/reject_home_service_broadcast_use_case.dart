import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_home_service_broadcast_repo.dart';

class RejectHomeServiceBroadcastUseCase {
  final IBarberHomeServiceBroadcastRepo _repo;

  RejectHomeServiceBroadcastUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int candidateId) =>
      _repo.reject(candidateId);
}
