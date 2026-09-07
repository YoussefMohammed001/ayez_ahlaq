import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_auth_repo.dart';

class ResendMerchantRegisterOtpUseCase {
  final IMerchantAuthRepo _repo;

  ResendMerchantRegisterOtpUseCase(this._repo);

  Future<Either<Failure, String>> call(String phone) =>
      _repo.resendRegisterOtp(phone);
}
