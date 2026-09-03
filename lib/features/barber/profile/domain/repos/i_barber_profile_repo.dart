import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_profile.dart';

abstract class IBarberProfileRepo {
  Future<Either<Failure, BarberProfile>> getProfile();

  Future<Either<Failure, BarberProfile>> updateLocation({
    double? latitude,
    double? longitude,
    String? address,
  });

  Future<Either<Failure, Unit>> changePassword(
    String currentPassword,
    String newPassword,
  );
}
