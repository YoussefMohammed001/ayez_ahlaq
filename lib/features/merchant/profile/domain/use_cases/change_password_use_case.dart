import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_profile_repo.dart';

class ChangePasswordUseCase {
  final IMerchantProfileRepo _repo;

  ChangePasswordUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String current, String next) =>
      _repo.changePassword(current, next);
}
