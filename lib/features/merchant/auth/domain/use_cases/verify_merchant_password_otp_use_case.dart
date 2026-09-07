import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/domain/entities/password_reset_ticket.dart';
import '../repos/i_merchant_auth_repo.dart';

class VerifyMerchantPasswordOtpUseCase {
  final IMerchantAuthRepo _repo;

  VerifyMerchantPasswordOtpUseCase(this._repo);

  Future<Either<Failure, PasswordResetTicket>> call(
    String phone,
    String code,
  ) => _repo.verifyPasswordOtp(phone, code);
}
