import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class ICustomerDeviceTokenRepo {
  Future<Either<Failure, Unit>> register(
    String token,
    String platform, {
    double? lat,
    double? lng,
  });

  Future<Either<Failure, Unit>> unregister(String token);

  Future<Either<Failure, Unit>> unregisterAll();
}
