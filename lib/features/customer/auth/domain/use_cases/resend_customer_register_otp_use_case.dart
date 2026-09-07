import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_auth_repo.dart';

class ResendCustomerRegisterOtpUseCase {
  final ICustomerAuthRepo _repo;

  ResendCustomerRegisterOtpUseCase(this._repo);

  Future<Either<Failure, String>> call(String phone) =>
      _repo.resendRegisterOtp(phone);
}
