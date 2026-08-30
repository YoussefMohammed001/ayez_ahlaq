import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_phone.dart';
import '../entities/merchant_profile.dart';

abstract class IMerchantProfileRepo {
  Future<Either<Failure, MerchantProfile>> getProfile();

  Future<Either<Failure, MerchantProfile>> updateProfile({
    required String businessName,
    required String ownerName,
    String? email,
  });

  Future<Either<Failure, Unit>> changePassword(
    String currentPassword,
    String newPassword,
  );

  Future<Either<Failure, List<MerchantPhone>>> getPhones();

  Future<Either<Failure, MerchantPhone>> addPhone(String phone, String? label);

  Future<Either<Failure, Unit>> deletePhone(int id);
}
