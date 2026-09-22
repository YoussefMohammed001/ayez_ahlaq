import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/domain/entities/auth_session.dart';
import '../repos/i_merchant_auth_repo.dart';

class VerifyMerchantRegisterOtpUseCase {
  final IMerchantAuthRepo _repo;

  VerifyMerchantRegisterOtpUseCase(this._repo);

  Future<Either<Failure, AuthSession>> call(String phone, String otp) =>
      _repo.verifyRegisterOtp(phone, otp);
}
