import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class IBarberBroadcastRepo {
  Future<Either<Failure, Unit>> send({
    required String scope,
    required String title,
    required String body,
  });
}
