import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_profile.dart';
import '../repos/i_merchant_profile_repo.dart';

class GetMerchantProfileUseCase {
  final IMerchantProfileRepo _repo;

  GetMerchantProfileUseCase(this._repo);

  Future<Either<Failure, MerchantProfile>> call() => _repo.getProfile();
}
