import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_profile.dart';
import '../repos/i_merchant_profile_repo.dart';

class UpdateMerchantProfileUseCase {
  final IMerchantProfileRepo _repo;

  UpdateMerchantProfileUseCase(this._repo);

  Future<Either<Failure, MerchantProfile>> call({
    required String businessName,
    required String ownerName,
    String? email,
  }) => _repo.updateProfile(
    businessName: businessName,
    ownerName: ownerName,
    email: email,
  );
}
