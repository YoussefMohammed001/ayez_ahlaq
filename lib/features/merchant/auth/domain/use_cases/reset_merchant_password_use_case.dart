import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_auth_repo.dart';

class ResetMerchantPasswordUseCase {
  final IMerchantAuthRepo _repo;

  ResetMerchantPasswordUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String resetToken, String newPassword) =>
      _repo.resetPassword(resetToken, newPassword);
}
