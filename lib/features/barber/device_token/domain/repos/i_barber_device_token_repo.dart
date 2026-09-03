import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class IBarberDeviceTokenRepo {
  Future<Either<Failure, Unit>> register(String token, String platform);

  Future<Either<Failure, Unit>> unregister(String token);

  Future<Either<Failure, Unit>> unregisterAll();
}
