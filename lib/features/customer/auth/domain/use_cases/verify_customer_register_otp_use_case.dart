import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_auth_repo.dart';

class VerifyCustomerRegisterOtpUseCase {
  final ICustomerAuthRepo _repo;

  VerifyCustomerRegisterOtpUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String phone, String otp) =>
      _repo.verifyRegisterOtp(phone, otp);
}
