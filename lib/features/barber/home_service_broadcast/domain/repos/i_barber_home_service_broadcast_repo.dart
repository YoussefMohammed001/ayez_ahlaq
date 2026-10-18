import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_broadcast.dart';

abstract class IBarberHomeServiceBroadcastRepo {
  Future<Either<Failure, List<HomeServiceBroadcast>>> getBroadcasts();

  Future<Either<Failure, HomeServiceBroadcast>> getBroadcastForRequest(
    int requestId,
  );

  Future<Either<Failure, Unit>> accept(int candidateId);

  Future<Either<Failure, Unit>> reject(int candidateId);
}
