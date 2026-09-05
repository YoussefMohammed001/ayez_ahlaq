import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_profile.dart';
import '../repos/i_merchant_profile_repo.dart';

class UpdateMerchantLocationUseCase {
  final IMerchantProfileRepo _repo;

  UpdateMerchantLocationUseCase(this._repo);

  Future<Either<Failure, MerchantProfile>> call({
    double? latitude,
    double? longitude,
    String? address,
  }) => _repo.updateLocation(
    latitude: latitude,
    longitude: longitude,
    address: address,
  );
}
