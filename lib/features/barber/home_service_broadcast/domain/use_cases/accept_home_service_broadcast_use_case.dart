import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_home_service_broadcast_repo.dart';

class AcceptHomeServiceBroadcastUseCase {
  final IBarberHomeServiceBroadcastRepo _repo;

  AcceptHomeServiceBroadcastUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int candidateId) =>
      _repo.accept(candidateId);
}
