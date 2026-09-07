import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_auth_repo.dart';

class VerifyMerchantRegisterOtpUseCase {
  final IMerchantAuthRepo _repo;

  VerifyMerchantRegisterOtpUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String phone, String otp) =>
      _repo.verifyRegisterOtp(phone, otp);
}
