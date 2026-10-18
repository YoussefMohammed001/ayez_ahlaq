import 'dart:typed_data';
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

  Future<Either<Failure, BarberProfile>> updateServesClients(bool value);

  Future<Either<Failure, Unit>> changePassword(
    String currentPassword,
    String newPassword,
  );

  Future<Either<Failure, Unit>> deleteAccount(String password);

  Future<Either<Failure, Unit>> uploadProfileImage(String filePath);

  Future<Uint8List?> getCachedProfileImage();

  Future<Either<Failure, Uint8List>> getProfileImage();

  Future<Either<Failure, Unit>> deleteProfileImage();
}
