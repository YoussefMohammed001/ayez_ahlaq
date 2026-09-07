import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_auth_repo.dart';

class ForgotMerchantPasswordUseCase {
  final IMerchantAuthRepo _repo;

  ForgotMerchantPasswordUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String phone) =>
      _repo.forgotPassword(phone);
}
